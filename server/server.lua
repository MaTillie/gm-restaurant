local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for index, restaurant in ipairs(Config.Restaurants) do
            setMenu(restaurant.Job,restaurant.Menu)
            setRecipe(restaurant.Job,getRecipe(restaurant.Job))
            
            for i, stash in ipairs(restaurant.Carte) do
                exports.ox_inventory:RegisterStash(restaurant.Job.."plateau"..i, Config.TrayLabel, 20,2000)
            end
            exports.ox_inventory:RegisterStash(restaurant.Job.."virtualfridge", restaurant.TrayLabel, 100,2000000,vec3(-586.15, -277.09, 41.69))
            exports.ox_inventory:RegisterStash(restaurant.Job.."fridge","Frigo", 50, 200000, false,{[restaurant.Job] = 0})
        end        
        
    end    
end)

function PrintTable(t, indent)
    indent = indent or 0
    local prefix = string.rep(" ", indent)
    if type(t) == "table" then
        for k, v in pairs(t) do
            if type(v) == "table" then
                print(prefix .. tostring(k) .. ":")
                PrintTable(v, indent + 2)
            else
                print(prefix .. tostring(k) .. ": " .. tostring(v))
            end
        end
    else
        print(prefix .. tostring(t))
    end
end

function FridgeName()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    return player.PlayerData.job.name.."fridge" 
end

function VirtualFridgeName(source)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    return player.PlayerData.job.name.."virtualfridge" 
end

RegisterNetEvent('gm-restaurant:server:craft')
AddEventHandler('gm-restaurant:server:craft', function(ingredients,item,cfg,itemLabel,image)	
    local src = source
    if(ingredients) then
        print("pas null")
    else
        print("null")
    end

    print("craft "..itemLabel)

    local requis = true
    for ingredient, details  in pairs(ingredients) do
        local metadata = {
            label = details.label ,
            --imageurl = 'nui://gm-restaurant/web/image/'..item..'.png',       
        }

        if (exports.ox_inventory:GetItemCount(VirtualFridgeName(src), "leap_ingredient",metadata)< details.amount) then
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Il n'y a pas "..details.amount.." x "..details.label.." dans la réserve",duration=5000,position='center-right'})
            requis = false
            exports.ox_inventory:AddItem(VirtualFridgeName(src), "leap_ingredient",details.amount,metadata)
        end    
    end

    if requis then        
        for ingredient, details in pairs(ingredients) do
            exports.ox_inventory:RemoveItem(VirtualFridgeName(src), "leap_ingredient",details.amount,metadata)
        end

        local player = exports.qbx_core:GetPlayer(src)
        local lrec = getRecipe(player.PlayerData.job.name)
        local lkItem = lrec.List[item]

        local metadata = {
            label = itemLabel ,
            imageurl = lkItem.image,        
        }
        exports.ox_inventory:AddItem(src, lkItem.categorie, 1,metadata)
    end
end)	

RegisterNetEvent('gm-restaurant:server:craftCompo')
AddEventHandler('gm-restaurant:server:craftCompo', function(ingredients,item,quantity)	
    local src = source
    if(ingredients) then
        print("pas null")
    else
        print("null")
    end
    local requis = true
    for ingredient, amount in pairs(ingredients) do
        print("Ingrédient: " .. ingredient .. ", Quantité: " .. amount)
        local igd = exports.ox_inventory:GetItem(src, ingredient, nil, true)

        if igd and igd >= amount then
            requis = requis
        else
            requis = false
        end        
    end

    if requis then
        for ingredient, amount in pairs(ingredients) do
            exports.ox_inventory:RemoveItem(src, ingredient, amount)
        end
        exports.ox_inventory:AddItem(VirtualFridgeName(), item, quantity)
    end
end)


QBCore.Functions.CreateUseableItem('hogspub_ticket', function(source, item)
    TriggerEvent('gm-restaurant:server:useTicket', source, item.info or item.metadata,item.slot)
end)

QBCore.Functions.CreateUseableItem('hogspub_repas', function(source, item)
    TriggerEvent('gm-restaurant:server:useBoite', source, item.info or item.metadata,item.slot)
end)

function CreateRegisterItem(k)
    exports.qbx_core:CreateUseableItem(k, function(source, item)
        TriggerEvent('um-idcard:server:sendData', source, item.info or item.metadata)
    end)
end

RegisterNetEvent('gm-restaurant:server:order')
AddEventHandler('gm-restaurant:server:order', function(bill,data,cfg)
    local src = source
    print("order")

    if(data)then
        print("order data"..json.encode(data))
    else
        print("order data null")
    end


    exports.ox_inventory:AddItem(src, 'hogspub_ticket', 1, data)
    

    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        TriggerClientEvent('gm-restaurant:client:updateCarte', v.PlayerData.source,bill,cfg)  
    end    
end)


RegisterNetEvent('gm-restaurant:server:useTicket', function(source,metadata,slot)
    local src = source

    local items = {}

    local hasAllItems = true

    local player = exports.qbx_core:GetPlayer(src)
    local lrec = getRecipe(player.PlayerData.job.name)

    for _, item in ipairs(metadata) do       
        local lkItem = lrec.List[item.name]
        local mtdt = {
            label = item.label ,
          --  imageurl = lkItem.image,       
        }

        local itemCount = exports.ox_inventory:GetItemCount(src, lkItem.categorie,mtdt)
        print("itemname "..item.name.." amount "..item.amount )

        if itemCount < item.amount then
            hasAllItems = false
            table.insert(items, {
                name = item.label,
                amount = itemCount.."/"..item.amount,
                cl = notCompleted,
            })
        else
            table.insert(items, {
                name = item.label,
                amount = item.amount.."/"..item.amount,
                cl = completed,
            })
        end
    end
    
    if hasAllItems then
        -- Retirer le ticket
        exports.ox_inventory:RemoveItem(src, "hogspub_ticket", 1, metadata,slot)

        -- Retirer les items de la commande de l'inventaire du joueur
        for _, item in ipairs(metadata) do
            local lkItem = lrec.List[item.name]
            local mtdt = {
                label = item.label ,
                imageurl = lkItem.image,       
            }
            item.imageurl = lkItem.image
            item.categorie = lkItem.categorie
            exports.ox_inventory:RemoveItem(src, lkItem.categorie, item.amount, mtdt)
        end
        
        -- Ajouter l'item "repas_empaquete" avec les mêmes métadonnées
        exports.ox_inventory:AddItem(src, 'hogspub_repas', 1, metadata)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Vous avez empaqueté le repas !'})
    else
        local src = source
        local player = exports.qbx_core:GetPlayer(src)

        TriggerClientEvent('gm-restaurant:client:displayOrder', src, items,player.PlayerData.job.name)
    end   
end)

RegisterNetEvent('gm-restaurant:server:useBoite', function(source,metadata,slot)
    local src = source
    for _, item in ipairs(metadata) do
        local mtdt = {
            label = item.label ,
            imageurl = item.imageurl,       
        }
        exports.ox_inventory:AddItem(src, item.categorie , item.amount,mtdt)
    end 
    exports.ox_inventory:RemoveItem(src, "hogspub_repas", 1,metadata, slot)
end)

exports('hogspub_ticket', function(event, item, inventory, slot, data)
    -- print("Use ticket")
    if event == 'usingItem' then
        local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
        --print(json.encode(itemSlot.metadata, {indent=true}))
    end
end)

RegisterNetEvent('gm-restaurant:server:payment')
AddEventHandler('gm-restaurant:server:payment', function(bill,cfg)
    local src = source 
    print("server order")
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        TriggerClientEvent('gm-restaurant:client:updateCartePayed', v.PlayerData.source,bill,cfg)  
    end  
end)

-- Gestion des prix - Début --

-- Fonction pour sauvegarder les modifications dans config.lua
local function saveConfig(data)    
    print("saveConfig")
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local cfg = {}
    
    print("###### "..player.PlayerData.job.name)
    PrintTable(data,0)
    for index, restaurant in ipairs(Config.Restaurants) do
        print("#1")
        print(restaurant.Job)
        if(restaurant.Job == player.PlayerData.job.name)then
            print("#2")
            print(restaurant.Job)
            cfg = restaurant
            for itemName, newPrice in pairs(data) do
                print(itemName.." / "..newPrice)
                if cfg.Menu[itemName] then
                    cfg.Menu[itemName].price = newPrice
                end
            end
        end
    end
    local configFile = LoadResourceFile(GetCurrentResourceName(), "config/config_"..player.PlayerData.job.name..".lua")
    
    if(configFile)then
        print("configFile ok")
    else
        print("configFile pas ok")
    end

    -- Mise à jour de la section Menu uniquement
    local menuStart = configFile:find("Config.Menu = {")
    print("menuStart: "..menuStart)
    local menuEnd = configFile:find("%s*}%s*[^\n,]", menuStart)
    if not menuEnd then
        print("Erreur: Impossible de trouver la fin de 'Config.Menu'")
        return
    end

    menuEnd = menuEnd +2
    local newMenu = "Config.Menu = {\n"
    for k, v in pairs(cfg.Menu) do
        newMenu = newMenu .. string.format('    ["%s"] = { price = %.2f, categorie = "%s" },\n', k, v.price, v.categorie)
    end
    newMenu = newMenu .. "}\n"

    -- Remplacer uniquement la section Menu dans le fichier de config
    local updatedConfig = configFile:sub(1, menuStart - 1) .. newMenu .. configFile:sub(menuEnd + 1)

    -- Sauvegarder dans config.lua
    SaveResourceFile(GetCurrentResourceName(), "config/config_"..player.PlayerData.job.name..".lua", updatedConfig, -1)

    reloadRecipes(player.PlayerData.job.name)
end


-- Fonction pour mettre à jour le prix
RegisterNetEvent('gm-restaurant:server:updatePrice', function(data)
    saveConfig(data)
end)

-- Gestion des prix - Fin --

function reloadRecipes(job)
    dofile('./config/config_'..job..'.lua')
    print("Menu rechargé.")
end

local Menu = {}
local Recipe = {}

RegisterNetEvent('gm-restaurant:server:getMenu')
AddEventHandler('gm-restaurant:server:getMenu', function(job)
    return getMenu(job)
end)

RegisterNetEvent('gm-restaurant:server:setMenu')
AddEventHandler('gm-restaurant:server:setMenu', function(job,menu)
    setMenu(job,menu)
end)

RegisterNetEvent('gm-restaurant:server:getRecipe')
AddEventHandler('gm-restaurant:server:getRecipe', function(job)
    return getRecipe(job)
end)

RegisterNetEvent('gm-restaurant:server:setRecipe')
AddEventHandler('gm-restaurant:server:setRecipe', function(job,recipe)
    setRecipe(job,recipe)
end)

function getMenu(job)
    return Menu[job] 
end

function setMenu(job,menu)
    Menu[job] = menu
end

function getRecipe(job)
    return Recipe[job]
end

function setRecipe(job,recipe)
    Recipe[job] = recipe
end
local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for index, restaurant in ipairs(Config.Restaurants) do
            -- ToDo -- Charger les compo intermédiaires généraux
            -- print("onServerResourceStart")
            setLocalMenu(restaurant.Job,restaurant.Menu)
            setLocalRecipe(restaurant.Job,getRecipe(restaurant.Job))
            
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

function GetMetaDataItem(name,label,image,dishType,props)
    print("GetMetaDataItem name:"..name.." label:"..label.." image:"..image.." dishType:"..dishType.." props:"..props)
    return {ref = name,label = label ,imageurl = image,dishType=dishType,props=props}
end

function GetMetaDataIngredient(name,label)
    return {ref = name,label = label,}
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

RegisterNetEvent('gm-restaurant:server:craftCompo')
AddEventHandler('gm-restaurant:server:craftCompo', function(ingredients,item,quantity)	
    local src = source

    local requis = true
    for ingredient, amount in pairs(ingredients) do
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


QBCore.Functions.CreateUseableItem('gmr_ticket', function(source, item)
    TriggerEvent('gm-restaurant:server:useTicket', source, item.info or item.metadata,item.slot)
end)

QBCore.Functions.CreateUseableItem('gmr_repas', function(source, item)
    TriggerEvent('gm-restaurant:server:useBoite', source, item.info or item.metadata,item.slot)
end)

QBCore.Functions.CreateUseableItem('gmr_dish', function(source, item)
    print("gmr_dish")
    TriggerEvent('gm-restaurant:server:useDish', source, item.info or item.metadata,item.slot)
end)


function CreateRegisterItem(k)
    exports.qbx_core:CreateUseableItem(k, function(source, item)
        TriggerEvent('um-idcard:server:sendData', source, item.info or item.metadata)
    end)
end

RegisterNetEvent('gm-restaurant:server:order')
AddEventHandler('gm-restaurant:server:order', function(data)
    local src = source
    exports.ox_inventory:AddItem(src, 'gmr_ticket', 1, data)    
end)


RegisterNetEvent('gm-restaurant:server:useTicket', function(source,metadata,slot)
    local src = source

    local items = {}

    local hasAllItems = true

    local player = exports.qbx_core:GetPlayer(src)
    local lrec = getLocalRecipe(player.PlayerData.job.name)

   -- PrintTable(metadata)
    for _, item in ipairs(metadata) do     
        -- print(item.name)
        local lkItem = lrec.List[item.name]
        local mtdt = GetMetaDataItem(item.name,item.label,lkItem.image,lkItem.categorie,lkItem.props)

        local itemCount = exports.ox_inventory:GetItemCount(src, "gmr_dish",mtdt)

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
        local retour = {}
        exports.ox_inventory:RemoveItem(src, "gmr_ticket", 1, metadata,slot)
        -- Retirer les items de la commande de l'inventaire du joueur
        for _, item in ipairs(metadata) do
            local lkItem = lrec.List[item.name]
            local mtdt = GetMetaDataItem(item.name,item.label,lkItem.image,lkItem.categorie,lkItem.props)
            
            exports.ox_inventory:RemoveItem(src, "gmr_dish", item.amount, mtdt)

            table.insert(retour,{metadata =mtdt, amount=item.amount })
        end
        
        -- Ajouter l'item "repas_empaquete" avec les mêmes métadonnées
        exports.ox_inventory:AddItem(src, 'gmr_repas', 1, retour)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Vous avez empaqueté le repas !'})
    else
        local src = source
        local player = exports.qbx_core:GetPlayer(src)

        TriggerClientEvent('gm-restaurant:client:displayOrder', src, items,player.PlayerData.job.name)
    end   
end)

RegisterNetEvent('gm-restaurant:server:useBoite', function(source,metadata,slot)
    print("useBoite")
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    PrintTable(metadata)
    for _, item in ipairs(metadata) do
        exports.ox_inventory:AddItem(src, "gmr_dish", item.amount, item.metadata)
    end

    exports.ox_inventory:RemoveItem(src, "gmr_repas", 1,metadata, slot)
end)

RegisterNetEvent('gm-restaurant:server:useDish', function(source,metadata,slot)
    print("useDish")
    local src = source
    local cat = Config.FoodPreset[metadata.dishType]
    if(cat) then
        print("useDish cat")
        exports["cdev_needs"]:updateStats(src,cat.stats)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Pouette'})
        exports.ox_inventory:RemoveItem(src, "gmr_dish", 1,metadata, slot)
        TriggerClientEvent('gm-restaurant:client:playConsumptionAnimation', src, metadata.props)

        print(cat.alcool)
        if(cat.alcool>0)then
            exports['cs_drunk']:AddDrunkLevel(src, cat.alcool)
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        end
        
        
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Pas pouette'})
    end
    
    

    
end)



exports('gmr_ticket', function(event, item, inventory, slot, data)
    -- print("Use ticket")
    if event == 'usingItem' then
        local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
        --print(json.encode(itemSlot.metadata, {indent=true}))
    end
end)

-- #################################################################################################### --
-- ## Début de Section - Gestion dynamique du menu et des recettes ## --
-- #################################################################################################### --

-- Fonction pour sauvegarder les modifications dans config.lua
local function savePriceFile(data)    
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local cfg = {}
    local result = {}
    for index, restaurant in ipairs(Config.Restaurants) do
        if(restaurant.Job == player.PlayerData.job.name)then
            cfg = restaurant
            for key, item in pairs(data) do
                result[item.name] = { price = item.price,categorie = item.categorie }
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
    for k, v in pairs(result) do
        newMenu = newMenu .. string.format('    ["%s"] = { price = %.2f, categorie = "%s" },\n', k, v.price, v.categorie)
    end
    newMenu = newMenu .. "}\n"

    -- Remplacer uniquement la section Menu dans le fichier de config
    local updatedConfig = configFile:sub(1, menuStart - 1) .. newMenu .. configFile:sub(menuEnd + 1)

    -- Sauvegarder dans config.lua
    SaveResourceFile(GetCurrentResourceName(), "config/config_"..player.PlayerData.job.name..".lua", updatedConfig, -1)
    setLocalMenu(player.PlayerData.job.name,result)
end

local function saveRecipeFile(data)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local cfg = {}

    print("saveRecipeFile0")

    local configFile = LoadResourceFile(GetCurrentResourceName(), "config/recipe_"..player.PlayerData.job.name..".lua")

    -- Mise à jour de la section Recipe uniquement
    local menuStart = configFile:find("Recipes.List = {")
    
    local menuEnd = configFile:find("%s*}%s*[^\n,]", menuStart)

    if not menuEnd then
        print("Erreur: Impossible de trouver la fin de 'Recipes.List'")
        return
    end

   -- menuEnd = menuEnd +2

    local newRecipe = "Recipes.List = {\n"
    for recipe, detail in pairs(data)do
        if(not detail.amount)then
            detail.amount = 1
        end
        print("test editable")
        print(detail.editable)
        if (not detail.editable) then
            detail.editable = false
        end

        print("test editable1")
        print(detail.editable)

        print("saveRecipeFile1 "..recipe.."/"..detail.label)
        newRecipe = newRecipe .. string.format('    ["%s"] = { \n', recipe)
        newRecipe = newRecipe .. string.format('              categorie = "%s",\n', detail.categorie)
        newRecipe = newRecipe .. string.format('              label = "%s",\n', detail.label)
        newRecipe = newRecipe .. string.format('              image = "%s",\n',  detail.image)
        newRecipe = newRecipe .. string.format('              props = "%s",\n',  detail.props)
        newRecipe = newRecipe .. string.format('              amount = %s,\n',  detail.amount)
        newRecipe = newRecipe .. string.format('              editable = %s,\n',  detail.editable)  
        newRecipe = newRecipe .. string.format('              ingredients = {\n')
       -- PrintTable(detail.ingredients)
        for igd, igdDetail in pairs(detail.ingredients) do
            if type(igdDetail) == "table" then
                if(igdDetail.amount>0)then
                    newRecipe = newRecipe .. string.format('                        ["%s"] = {amount = %s},\n', igd, igdDetail.amount)
                end
            else
                print("Attention : " .. igd .. " contient une valeur inattendue de type " .. type(igdDetail))
            end
        end
        newRecipe = newRecipe .. string.format('              },\n')
        newRecipe = newRecipe .. string.format('    },\n')
    end

    -- Remplacer uniquement la section Menu dans le fichier de config
    local updatedConfig = configFile:sub(1, menuStart - 1) .. newRecipe .. configFile:sub(menuEnd + 1)

    SaveResourceFile(GetCurrentResourceName(), "config/recipe_"..player.PlayerData.job.name..".lua", updatedConfig, -1)
    local lRcp = getLocalRecipe(player.PlayerData.job.name)
    lRcp.List = data
    setLocalRecipe(player.PlayerData.job.name,lRcp)
end


-- Fonction pour mettre à jour le prix
RegisterNetEvent('gm-restaurant:server:updatePrice', function(data)
    savePriceFile(data)
end)

RegisterNetEvent('gm-restaurant:server:updateRecipe', function(data)
    saveRecipeFile(data)
end)


local Menu = {}
local Recipe = {}

RegisterNetEvent('gm-restaurant:server:getMenu')
AddEventHandler('gm-restaurant:server:getMenu', function(job)
    local src = source
    TriggerClientEvent('gm-restaurant:client:receiveMenu', src,job, getLocalMenu(job))
end)

RegisterNetEvent('gm-restaurant:server:setMenu')
AddEventHandler('gm-restaurant:server:setMenu', function(job,menu)
    setLocalMenu(job,menu)
end)

RegisterNetEvent('gm-restaurant:server:getRecipe')
AddEventHandler('gm-restaurant:server:getRecipe', function(job)
    local src = source
    TriggerClientEvent('gm-restaurant:client:receiveRecipe', src,job, getLocalRecipe(job))
end)

RegisterNetEvent('gm-restaurant:server:setRecipe')
AddEventHandler('gm-restaurant:server:setRecipe', function(job,recipe)
    setRecipe(job,recipe)
end)

function getLocalMenu(job)
    return Menu[job] 
end

function setLocalMenu(job,menu)
    Menu[job] = menu
end

function getLocalRecipe(job)
    return Recipe[job]
end

function setLocalRecipe(job,recipe)
    Recipe[job] = recipe
end

-- #################################################################################################### --
-- ## Fin de Section - Gestion dynamique du menu et des recettes ## --
-- #################################################################################################### --

-- #################################################################################################### --
-- ## Début de Section - Gestion de la commande d'ingrédients ## --
-- #################################################################################################### --

local IngredientOrder = {}
-- Retour des commandes d'ingrédients
RegisterNetEvent('gm-restaurant:server:setIngredientOrder')
AddEventHandler('gm-restaurant:server:setIngredientOrder', function(order)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    IngredientOrder[player.PlayerData.job.name] = {}
    IngredientOrder[player.PlayerData.job.name].order = order
    IngredientOrder[player.PlayerData.job.name].done = false
end)

RegisterNetEvent('gm-restaurant:server:getIngredientOrder')
AddEventHandler('gm-restaurant:server:getIngredientOrder', function(job)
    local src = source
    TriggerClientEvent('gm-restaurant:client:getIngredientOrder', src,IngredientOrder[job])  
end)

RegisterNetEvent('gm-restaurant:server:paidIngredientOrder')
AddEventHandler('gm-restaurant:server:paidIngredientOrder', function(job)
    local src = source
    if not IngredientOrder[job] then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Aucune commande en cours",duration=5000,position='center-right'})           
    else
        local total = 0
        PrintTable(IngredientOrder[job].order)
        for item, detail in pairs(IngredientOrder[job].order) do
            
            total = total + detail.quantity*detail.price

            local label = IngList.Base[item].label
            print(item.."/"..label)
            local metadata = GetMetaDataIngredient(item,label)
            local qte = IngList.Base[item].amount*detail.quantity
            exports.ox_inventory:AddItem(VirtualFridgeName(src), "gmr_ingredient",qte,metadata)            
           

        end
        IngredientOrder[job] = {}
        exports['okokBanking']:RemoveMoney(job, total)
        /* Pour les logs des courses :

okokbanking_transactions
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`receiver_identifier` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- job
	`receiver_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- jopizza (Custom)
	`sender_identifier` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- "Commande"
	`sender_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- Ingrédients
	`date` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- 2024-10-22 22:14:35
	`value` INT(50) NOT NULL, -- montant
	`type` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- "transfer"

*/
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = "Commande terminée",duration=5000,position='center-right'})  

    end
end)




-- #################################################################################################### --
-- ## Fin de Section - Gestion de la commande d'ingrédients ## --
-- #################################################################################################### --

-- #################################################################################################### --
-- ## Début de Section - Ajout des ingrédients farmable par les joueurs ## --
-- #################################################################################################### --

-- Récupère la liste des items de farm que possède le joueur pour qu'il puisse les ajouter au stockage virtuel
RegisterNetEvent('gm-restaurant:server:getPlayerIngredients')
AddEventHandler('gm-restaurant:server:getPlayerIngredients', function()
    local src = source    
    local player = exports.qbx_core:GetPlayer(src)

    local retour = {}

    print("getPlayerIngredients")
    
    for item,detail in pairs(IngList.Player) do        
        local nb = exports.ox_inventory:GetItemCount(src, item)
        if (nb>0) then
            local fitem = exports.ox_inventory:Items()[item]
            table.insert(retour, {item=item, amount=nb,isMetadata = false, label=fitem.label}) 
        end
    end

    for item,detail in pairs(getLocalRecipe(player.PlayerData.job.name).List) do
        print("#"..item)
        local metadata = GetMetaDataItem(item,detail.label,detail.image,detail.categorie,detail.props)
        print("#"..detail.label)
        local nb = exports.ox_inventory:GetItemCount(src, "gmr_dish", metadata)
        if (nb>0) then
            print("##"..item)
            table.insert(retour, {item="gmr_dish", amount=nb,label = detail.label,metadata=metadata,isMetadata = true}) 
        end
    end
    
    TriggerClientEvent('gm-restaurant:client:getPlayerIngredients', src,retour)  
end)

-- Retire les items de farm de l'inventaire du joueur pour les convertir en ingrédients dans le stockage virtuel
RegisterNetEvent('gm-restaurant:server:getPlayerIngredient')
AddEventHandler('gm-restaurant:server:getPlayerIngredient', function(data)
    print("gm-restaurant:server:getPlayerIngredient")
    local src = source
    PrintTable(data)
    
    if(not data.isMetadata) then
        local nb = exports.ox_inventory:GetItemCount(src, data.item)
        if (nb>=data.amount) then
            local igd = IngList.Player[data.item].item
            local qte = IngList.Player[data.item].amount
            local total = qte*data.amount
            local metadata = GetMetaDataIngredient(igd,IngList.Base[igd].label)

            exports.ox_inventory:RemoveItem(src, data.item,data.amount)

            exports.ox_inventory:AddItem(VirtualFridgeName(src), "gmr_ingredient",total,metadata)
        end
    else
        print("gm-restaurant:server:getPlayerIngredient1 ")
        local nb = exports.ox_inventory:GetItemCount(src,  data.item, data.metadata)
        print("gm-restaurant:server:getPlayerIngredient2 "..nb)
        if (nb>=data.amount) then
            print("gm-restaurant:server:getPlayerIngredient3")
            
            exports.ox_inventory:RemoveItem(src, data.item,data.amount, data.metadata)
            print(data.metadata.ref)
            exports.ox_inventory:AddItem(VirtualFridgeName(src), "gmr_ingredient",data.amount,GetMetaDataIngredient(data.metadata.ref,data.metadata.label))
        end        
    end

end)

-- #################################################################################################### --
-- ## Fin de Section - Ajout des ingrédients farmable par les joueurs ## --
-- #################################################################################################### --

-- #################################################################################################### --
-- ## Début de Section - goCraftProduct ## --
-- #################################################################################################### --

RegisterNetEvent('gm-restaurant:server:canCraftProduct')
AddEventHandler('gm-restaurant:server:canCraftProduct', function(order)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    -- order.item order.amount
end)


RegisterNetEvent('gm-restaurant:server:craft')
AddEventHandler('gm-restaurant:server:craft', function(ingredients,item,itemLabel,categorie,image,amount)	
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
   -- print("craft "..item..'/'..itemLabel.." ("..amount..")")
    local job = player.PlayerData.job.name

    local lrec = getLocalRecipe(player.PlayerData.job.name)

    local requis = true
    for ingredient, details  in pairs(ingredients) do
    --   print("craft1 "..details.label)

        local metadata = GetMetaDataIngredient(ingredient,details.label)

        if (exports.ox_inventory:GetItemCount(VirtualFridgeName(src), "gmr_ingredient",metadata)< details.amount*amount) then
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Il n'y a pas "..details.amount*amount.." x "..details.label.." dans la réserve",duration=5000,position='center-right'})
            requis = false
          -- exports.ox_inventory:AddItem(VirtualFridgeName(src), "gmr_ingredient",details.amount*amount,metadata)
        end    
    end

    if requis then        
        for ingredient, details in pairs(ingredients) do
            -- print("delete "..details.label)
            local metadata = GetMetaDataIngredient(ingredient,details.label)
            exports.ox_inventory:RemoveItem(VirtualFridgeName(src), "gmr_ingredient",details.amount*amount,metadata)
        end

        local lkItem = lrec.List[item]
        local total = amount
        if(lkItem.amount) then
            total = total*lkItem.amount
        end
        local mtdt = GetMetaDataItem(item,itemLabel,lkItem.image,lkItem.categorie,lkItem.props)
        exports.ox_inventory:AddItem(src, "gmr_dish", total,mtdt)
    end


end)	

-- #################################################################################################### --
-- ## Fin de Section - goCraftProduct ## --
-- #################################################################################################### --


-- #################################################################################################### --
-- ## Début de Section - listFridgeIngredient ## --
-- #################################################################################################### --

function getlistFridgeIngredient(source) 
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    local data = exports.ox_inventory:GetInventoryItems(VirtualFridgeName(src), false)

    local retour = {}
   
    for _,item in pairs(data) do
        -- print(item.metadata.ref.." :"..item.metadata.label.." ("..item.count..")")
        table.insert(retour,{name=item.metadata.ref,label=item.metadata.label,count=item.count})
    end

    TriggerClientEvent('gm-restaurant:client:displayListFridgeIngredient', src, retour)  
end

RegisterNetEvent('gm-restaurant:server:getlistFridgeIngredient')
AddEventHandler('gm-restaurant:server:getlistFridgeIngredient', function()
    local src = source
    getlistFridgeIngredient(source) 
end)

-- #################################################################################################### --
-- ## Fin de Section - listFridgeIngredient ## --
-- #################################################################################################### --

-- #################################################################################################### --
-- ## Début de Section - getProxiPlayers ## --
-- #################################################################################################### --

RegisterNetEvent('gm-restaurant:server:getProxiPlayers')
AddEventHandler('gm-restaurant:server:getProxiPlayers', function(nearbyPlayers)
    -- print("getProxiPlayers")
    local src = source
    if #nearbyPlayers == 0 then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Aucun joueur à proximité'})
        return
    end
    local retour = {}
    -- Parcourir les joueurs à proximité et récupérer les informations
    for _, playerId in ipairs(nearbyPlayers) do
        local xPlayer = QBCore.Functions.GetPlayer(playerId)
        if xPlayer then
            local name = xPlayer.PlayerData.charinfo.firstname
            local surname = xPlayer.PlayerData.charinfo.lastname
            local citizenid = xPlayer.PlayerData.source
            --retour[citizenid] ={name=name.." "..surname ,citizenid=citizenid,}
            table.insert(retour,{name=name.." "..surname ,citizenid=citizenid,})
            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = string.format("Nom: %s %s | CitizenID: %s", name, surname, citizenid)})
        end
    end
    TriggerClientEvent('gm-restaurant:client:getProxiPlayers', src, retour)  
end)

-- #################################################################################################### --
-- ## Fin de Section - getProxiPlayers ## --
-- #################################################################################################### --

-- #################################################################################################### --
-- ## Début de Section - delivery ## --
-- #################################################################################################### --

RegisterNetEvent('gm-restaurant:server:delivery:valideDelivery')
AddEventHandler('gm-restaurant:server:delivery:valideDelivery', function(order)
    local src = source
    for _, item in ipairs(order) do
        exports.ox_inventory:RemoveItem(src,"gmr_dish", item.amount, item.metadata)
    end
end)

RegisterNetEvent('gm-restaurant:server:delivery:rewardPlayer')
AddEventHandler('gm-restaurant:server:delivery:rewardPlayer', function(currentOrder)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local total = 0

    for _, item in ipairs(order) do
        total = total+price
    end

    xPlayer.Functions.AddMoney('cash', total)
    local amountJob = (total- (total%2))/4 -- le quart
    exports['okokBanking']:AddMoney(xPlayer.job.name, amountJob)

end)

-- #################################################################################################### --
-- ## Fin de Section - delivery ## --
-- #################################################################################################### --
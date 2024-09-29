local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for index, restaurant in ipairs(Config.Restaurants) do
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


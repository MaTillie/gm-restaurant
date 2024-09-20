local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for index, restaurant in ipairs(Restaurants) do
            print("A2 "..restaurant)
            local cheminConfig = string.format('config_%s.lua', restaurant)
            local Config
            local status, err = pcall(function() 
                Config = {} -- Reset Config pour chaque entreprise
                dofile(cheminConfig) -- Charger le fichier de config spécifique
            end)
            for i, stash in ipairs(Config.Carte) do
                exports.ox_inventory:RegisterStash(Config.Job.."plateau"..i, Config.TrayLabel, 20,2000)
            end
            exports.ox_inventory:RegisterStash(Config.Job.."virtualfridge", Config.TrayLabel, 100,2000000)
            exports.ox_inventory:RegisterStash(Config.Job.."fridge","Frigo", 50, 200000, false,{[Config.Job] = 0})
        end        
    end    
end)

function FridgeName()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    return player.PlayerData.job.name.."fridge" 
end

function VirtualFridgeName()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    return player.PlayerData.job.name.."virtualfridge" 
end

RegisterNetEvent('gm-restaurant:server:craft')
AddEventHandler('gm-restaurant:server:craft', function(ingredients,item)	
    local src = source
    if(ingredients) then
        print("pas null")
    else
        print("null")
    end

    local requis = true
    for ingredient, amount in pairs(ingredients) do
        if (exports.ox_inventory:GetItemCount(VirtualFridgeName(), ingredient)< amount) then
            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = "Il n'y a pas "..amount.." x "..exports.ox_inventory:Items()[item].label.." dans la réserve"})
            requis = false
        end    
    end

    if requis then
        for ingredient, amount in pairs(ingredients) do
            exports.ox_inventory:RemoveItem(VirtualFridgeName(), ingredient, amount)
        end
        exports.ox_inventory:AddItem(src, item, 1)
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
    for _, item in ipairs(metadata) do
        local itemCount = exports.ox_inventory:Search(src, 'count', item.name)
        if itemCount < item.amount then
            hasAllItems = false
            table.insert(items, {
                name = gm_bridge_itemLabel(item.name),
                amount = itemCount.."/"..item.amount,
                cl = notCompleted,
            })
        else
            table.insert(items, {
                name = gm_bridge_itemLabel(item.name),
                amount = item.amount.."/"..item.amount,
                cl = completed,
            })
        end
    end
    
    if hasAllItems then
        -- Retirer les items de la commande de l'inventaire du joueur
        for _, item in ipairs(metadata) do
            exports.ox_inventory:RemoveItem(src, item.name, item.amount)
        end
        exports.ox_inventory:RemoveItem(src, "hogspub_ticket", 1, metadata,slot)
        -- Ajouter l'item "repas_empaquete" avec les mêmes métadonnées
        exports.ox_inventory:AddItem(src, 'hogspub_repas', 1, metadata)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Vous avez empaqueté le repas !'})
    else
        TriggerClientEvent('gm-restaurant:client:displayOrder', src, items)
    end   
end)

RegisterNetEvent('gm-restaurant:server:useBoite', function(source,metadata,slot)
    local src = source
    for _, item in ipairs(metadata) do
        exports.ox_inventory:AddItem(src, item.name, item.amount)
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


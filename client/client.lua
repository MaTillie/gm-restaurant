local QBCore = exports['qb-core']:GetCoreObject()
local config = require 'config'

local idCaisses = {}
local orderDisplayOpen = false

local function coordsEqual(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
end

function initKitchen(cfg,key)
    for key, kitchen in pairs(cfg.Kitchen) do
        local options = {}
        for _, item in ipairs(kitchen.items) do
            
            local formattedIngredients = {}
            if(cfg.DebugMode) then
                print("initKitchen item: "..item)
            end
            for ingredient, details in pairs(cfg.Menu[item].ingredients) do
                if(cfg.DebugMode) then
                    print("initKitchen recipe detail : " .. ingredient .. ": " .. details.amount)
                end
                formattedIngredients[ingredient] = details.amount
            end

            table.insert(options,{
                name = item, 
                label = exports.ox_inventory:Items()[item].label,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    local success = lib.progressBar({duration = kitchen.duration, label = kitchen.title, disable = {
                        move = true,
                        car = true,
                        mouse = false,
                        combat = true,
                    }})
                    if success then                                          
                        TriggerServerEvent('gm-restaurant:server:craft',formattedIngredients,item,key)
                        if(cfg.DebugMode) then  
                            print("Progress success for: " .. item)    
                        end
                    else
                        if(cfg.DebugMode) then  
                            print("Progress cancelled for: " .. item)
                        end
                    end                    
                end,
                groups = cfg.job,
            });
        end

        exports.ox_target:addSphereZone({ 
            coords = kitchen.coords,
            radius = kitchen.size,
            debug = cfg.DebugMode,
            options = options                
        })
    end
end

function initFidge(cfg,key)
    for key, fridge in pairs(cfg.Fridge) do
        local options = {}

        for _, item in ipairs(fridge.items) do
            table.insert(options,{
                name = item,  -- Nom de l'option, unique pour chaque interaction
                label = exports.ox_inventory:Items()[item].label,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    --local success = lib.progressBar({duration = 1000, label = "Fouille"})
                    local success = lib.progressBar({duration = 1000, label = "Fouille", disable = {
                        move = true,
                        car = true,
                        mouse = false,
                        combat = true,
                    }})
                    if success then
                        TriggerServerEvent('gm-restaurant:server:craft',{},item)    
                        if(cfg.DebugMode) then  
                            print("Progress success for: " .. item)    
                        end                                          
                    else
                        if(cfg.DebugMode) then  
                            print("Progress cancelled for: " .. item)
                        end
                    end
                end,
                groups = cfg.job,
            });

                    
        end
        exports.ox_target:addSphereZone({ 
            coords = fridge.coords,
            radius = fridge.size,
            debug = cfg.DebugMode,
            options = options                
        }) 
    end 
end

local function init()
    for index, restaurant in ipairs(Config.Restaurants) do
        initFidge(restaurant,index)
       -- initKitchen(restaurant,index)
        initCarte(restaurant,index)
    end
end

function initCarte(cfg,key)
    local options = {}
    idCaisses ={}

    for index, caisse in pairs(cfg.Carte) do
        local options = {}
        table.insert(options,{
            name = "carte",  -- Nom de l'option, unique pour chaque interaction
            label = caisse.title,  -- Texte affiché à l'utilisateur
            icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                lauchMenu(cfg,key)
            end,
        });

        table.insert(options,{
            name = "order",  -- Nom de l'option, unique pour chaque interaction
            label = "Caisse",  -- Texte affiché à l'utilisateur
            icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()     
                print("key launchCaisse "..index)               
                launchCaisse(index,cfg,key)
            end,
            groups = cfg.Job,
        });

        table.insert(options,{
            name = "plateau",  -- Nom de l'option, unique pour chaque interaction
            label = "Plateau",  -- Texte affiché à l'utilisateur
            icon = 'fa-solid fa-plate-utensils',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                exports.ox_inventory:openInventory('stash', cfg.Job.."plateau"..index)
            end,
        });


        local idCaisse = exports.ox_target:addSphereZone({ 
            coords = caisse.coords,
            radius = caisse.size,
            debug = cfg.DebugMode,
            options = options   })    

        table.insert(idCaisses,{id=idCaisse,index = index, key=key})  
    end
end



--[[function lauchMenu(cfg,key)
  SetNuiFocus(true, true)
  local Menu = {}  
  Menu.items = cfg.Menu
  Menu.key = key
  Menu.theme = "styles_"..cfg.Job..".css"
  Menu.cfg = cfg
  for item, menu in pairs(Menu.items) do
    menu.Label = exports.ox_inventory:Items()[item].label
  end

  

    SendNUIMessage({
        action = 'openMenu',
        toggle = true,
        data = Menu
    })

end]]--
function lauchMenu(cfg, key)
    SetNuiFocus(true, true)
    local Menu = {}
    Menu.items = {}
    Menu.key = key
    Menu.theme = "styles_" .. cfg.Job .. ".css"
    Menu.cfg = cfg

   -- Parcourir les catégories dans l'ordre défini
   for _, categorie in ipairs(cfg.Categorie) do
    local categoryItems = {}

        -- Parcourir les items et les assigner à leur catégorie
        for item, menu in pairs(cfg.Menu) do
            if menu.categorie == categorie.name then
                local itemData = {
                    Label = exports.ox_inventory:Items()[item].label,
                    price = menu.price
                }
                table.insert(categoryItems, itemData)
            end
        end

        -- Ajouter la catégorie seulement si elle contient des items
        if #categoryItems > 0 then
            table.insert(Menu.items, {
                label = categorie.label,
                name = categorie.name,
                items = categoryItems
            })
        end
    end

    SendNUIMessage({
        action = 'openMenu',
        toggle = true,
        data = Menu
    })
end

function launchCaisse(indexCaisse,cfg,key)
    print("indexCaisse "..indexCaisse)
    SetNuiFocus(true, true)
    local Menu = {}
    Menu.items =cfg.Menu
    Menu.indexCaisse = indexCaisse
    Menu.key = key
    Menu.theme = "styles_"..cfg.Job..".css"
    Menu.cfg = cfg
    for item, menu in pairs(Menu.items) do
      menu.Label = exports.ox_inventory:Items()[item].label
    end
  
    SendNUIMessage({
        action = 'openOrder',
        toggle = true,
        data = Menu
    })
  
end


AddEventHandler('onResourceStart', function(r) 
    if GetCurrentResourceName() ~= r then return end	
    init()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    init()
end)


function closeMenu()
    SetNuiFocus(false, false)
end

-- Retour du js, permet de récuépérer les informations nécessaire à la facture
function order(data)
    print("order indexCaisse "..data.indexCaisse)
    local player = source
    local items = {}

    for _, item in ipairs(data.items) do
        table.insert(items, {
            name = exports.ox_inventory:Items()[item.name].label,
            amount = item.quantity
        })
    end

    local metadata = {
        items = items
    }

    local bill ={}

    local playerData = QBCore.Functions.GetPlayerData()

    local billFrom = {
        citizen = playerData.citizenid,
        name = playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname,
        job = playerData.job.name,
    }

    local descReduc = ""
    if (data.reduc < 0) then
        descReduc = "Surcoût de $"..data.reduc
    else if (data.reduc > 0) then
        descReduc = "Réduction de $"..data.reduc
    end
    end

    local description = descReduc..","
    local amount = 0.0
    for _, item in ipairs(data.items) do
        description = description..item.label.." x"..item.quantity..", "
        amount = amount + item.quantity * item.price
    end    

    
    bill.indexCaisse = data.indexCaisse
    bill.referance = createReference()
    bill.title = data.cfg.invoiceWording
    bill.description = description
    bill.billFrom = billFrom
    bill.amount = amount + (data.reduc * -1)
    bill.status = "unpaid"
    bill.type = "compagny"
    local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] = GetLocalTime()
    bill.date = year.."-"..month.."-"..day
    
    TriggerServerEvent('gm-restaurant:server:order',bill,items,data.cfg)   
end

-- Met à jour la caisse la plus proche pour ajouter l'option payer 
RegisterNetEvent('gm-restaurant:client:updateCarte')
AddEventHandler('gm-restaurant:client:updateCarte', function(bill,cfg)
    print("updateCarte")
    local idCaisse = nil
    local index 

    for i, v in ipairs(idCaisses) do
        if(v.index == bill.indexCaisse)then
            index = i
            idCaisse = v.id 
        end
    end

    table.remove(idCaisses, index)
    exports.ox_target:removeZone(idCaisse)


    for key, caisse in pairs(cfg.Carte) do
        if(key == bill.indexCaisse)then
            print("updateCarte égale")
            local options = {}
            table.insert(options,{
                name = "carte",  -- Nom de l'option, unique pour chaque interaction
                label = caisse.title,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    lauchMenu(cfg,key)
                end,
            });

            table.insert(options,{
                name = "payment",  -- Nom de l'option, unique pour chaque interaction
                label = "Payer",  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    createBill(bill)
                end,
            });

            table.insert(options,{
                name = "order",  -- Nom de l'option, unique pour chaque interaction
                label = "Caisse",  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    launchCaisse(index,cfg,key)
                end,
                groups = cfg.Job,
            });

            table.insert(options,{
                name = "plateau",  -- Nom de l'option, unique pour chaque interaction
                label = "Plateau",  -- Texte affiché à l'utilisateur
                icon = 'fa-solid fa-plate-utensils',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    exports.ox_inventory:openInventory('stash', cfg.Job.."plateau"..key)
                end,
            });

            


            local lidCaisse = exports.ox_target:addSphereZone({ 
                coords = caisse.coords,
                radius = caisse.size,
                debug = cfg.DebugMode,
                options = options   })    

            table.insert(idCaisses,{id=lidCaisse,index = key})  
        end
    end


end)

function createBill(bill,cfg)
    local msg = "La  facture vient de vous être émise. Utilisez votre application de paiement favorite."
    exports.qbx_core:Notify(msg, "inform",10000,"",'center-right')
    local playerData = QBCore.Functions.GetPlayerData()

    local billTo = {
        citizen = playerData.citizenid,
        name = playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname,
    }
    
    bill.billTo = billTo

    TriggerServerEvent('dusa_billing:sv:createBill',bill)  

    TriggerServerEvent('gm-restaurant:server:payment',bill,cfg)   
    
end

-- Gestion du NUI Callback
RegisterNUICallback('nuiCallback', function(data, cb)
    if data.action == 'closeMenu' then
        closeMenu()  -- Appelle la fonction Lua avec le paramètre envoyé depuis JS
    else if(data.action == 'order')then
    end
        order(data.param,data.cfg)
    end

    cb('ok')  -- Réponse à envoyer au JS
end)

function createReference()
    local result = ''
    local characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local charactersLength = string.len(characters)
    local counter = 0

    while counter < 10 do
        local randomIndex = math.random(1, charactersLength)
        result = result .. string.sub(characters, randomIndex, randomIndex)
        counter = counter + 1
    end

    return result
end


RegisterNetEvent('gm-restaurant:client:updateCartePayed')
AddEventHandler('gm-restaurant:client:updateCartePayed', function(bill,cfg)
    if(cfg.DebugMode)then
        print("updateCartePayed")
    end
    local idCaisse = nil

    local index 

    for i, item in ipairs(idCaisses) do
        if(item.index == bill.indexCaisse)then
            idCaisse = item.id 
            index = i
        end
    end   

    
    table.remove(idCaisses, index)
    exports.ox_target:removeZone(idCaisse)

    for key, caisse in pairs(cfg.Carte) do
        if(key == bill.indexCaisse)then
            print("updateCarte égale")
            local options = {}
            table.insert(options,{
                name = "carte",  -- Nom de l'option, unique pour chaque interaction
                label = caisse.title,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    lauchMenu(cfg,key)
                end,
            });

            table.insert(options,{
                name = "order",  -- Nom de l'option, unique pour chaque interaction
                label = "Caisse",  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    launchCaisse(index,cfg,key)
                end,
                groups = cfg.Job,
            });

            table.insert(options,{
                name = "plateau",  -- Nom de l'option, unique pour chaque interaction
                label = "Plateau",  -- Texte affiché à l'utilisateur
                icon = 'fa-solid fa-plate-utensils',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    exports.ox_inventory:openInventory('stash', cfg.Job.."plateau"..key)
                end,
            });


            local lidCaisse = exports.ox_target:addSphereZone({ 
                coords = caisse.coords,
                radius = caisse.size,
                debug = cfg.DebugMode,
                options = options   })    

            table.insert(idCaisses,{id=lidCaisse,index = key})  
        end
    end


end)


-- Fonction pour afficher la commande
RegisterNetEvent('gm-restaurant:client:displayOrder')
AddEventHandler('gm-restaurant:client:displayOrder', function(orderItems,job)   
     
    orderDisplayOpen = true
    print("displayOrder")    
    if(orderItems)then
        print("order data"..json.encode(orderItems))
    else
        print("order data null")
    end
    local data ={}
    data.items = orderItems
    data.theme = "styles_"..job..".css" 
    print(data.theme)
    orderDisplayOpen = true
    -- On envoie les items à la NUI (HTML)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openTicket",
        data = data
    })


end)

-- Gestion de la fermeture de l'affichage avec la touche échapp
CreateThread(function()
    while true do
        if orderDisplayOpen then
            if IsControlJustPressed(0, 200) then -- Touche Esc (200 correspond à la touche échap)
                lib.hideTextUI() -- Cache l'UI de commande
                orderDisplayOpen = false
            end
        end
        Wait(0)
    end
end)

-- ouvrir le plateau exports.ox_inventory:openInventory('stash', Config.job.."plateau")
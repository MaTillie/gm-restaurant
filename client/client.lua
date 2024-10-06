local QBCore = exports['qb-core']:GetCoreObject()
local config = require 'config'

local idCaisses = {}
local orderDisplayOpen = false

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

local function coordsEqual(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
end

function initKitchen(cfg,key)
    local localRecipes = {}
    local Recipes = {}
    localRecipes = getRecipe(cfg.Job)
    Recipes = IngList.Compo
    for key, kitchen in pairs(cfg.Kitchen) do
        local options = {}        
        for _, item in ipairs(kitchen.items) do
            
            local formattedIngredients = {}
            local recipeLabel = item

            local rcp = localRecipes.List[item]
            local rcpCompo = IngList.Compo[item]
            local rcpCompoLocal = localRecipes.Compo[item]

            if rcp then
                recipeLabel = rcp.label
            elseif rcpCompo then
                recipeLabel = rcpCompo.label
            elseif rcpCompoLocal then
                recipeLabel = rcpCompoLocal.label
            end

            if(cfg.DebugMode) then
                print("initKitchen item: "..item)
            end          

            for ingredient, details in pairs(localRecipes.List[item].ingredients) do
                local ingredientLabel = ingredient
                local igd = IngList.Base[ingredient]
                local igdCompo = IngList.Compo[ingredient]
                local igdCompoLocal = localRecipes.Compo[ingredient]

                if igd then
                    ingredientLabel = igd.label
                elseif igdCompo then
                    ingredientLabel = igdCompo.label
                elseif igdCompoLocal then
                    ingredientLabel = igdCompoLocal.label
                end


                if(cfg.DebugMode) then
                    print("initKitchen recipe detail : " .. ingredient .." ("..ingredientLabel..") : " .. details.amount)
                end
                

                formattedIngredients[ingredient] = {}
                formattedIngredients[ingredient].amount = details.amount
                formattedIngredients[ingredient].label = ingredientLabel
            end

            table.insert(options,{
                name = item, 
                label = recipeLabel,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-caret-right ',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()          
                    local success = true          
                   --[[ local success = lib.progressBar({duration = kitchen.duration, label = kitchen.title, disable = {
                        move = true,
                        car = true,
                        mouse = false,
                        combat = true,
                    }})]]
                    if success then                                          
                        TriggerServerEvent('gm-restaurant:server:craft',formattedIngredients,item,cfg,recipeLabel,img)
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

function RecipeBook(cfg,key)
    

    for index, caisse in pairs(cfg.RecipeBook) do
        local options = {}
        for item, menu in pairs(cfg.Menu) do
            table.insert(options,{
                name = "carte",  -- Nom de l'option, unique pour chaque interaction
                label = caisse.title,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    getRecipeItem(item,cfg)
                end,
            });
        end        
        

        local idCaisse = exports.ox_target:addSphereZone({ 
            coords = caisse.coords,
            radius = caisse.size,
            debug = cfg.DebugMode,
            options = options   })    

        table.insert(idCaisses,{id=idCaisse,index = index, key=key})  
    end

end

function getRecipeItem(item,cfg)
    local result = {}
    local lkItem = cfg.Menu[item]
    if (not lkItem) then
        local lrec = getRecipe(cfg.Job)
        lkItem = lrec.List[item]
    end

    if (not lkItem) then
        local lrec = getRecipe(cfg.Job)
        lkItem = lrec.Compo[item]
    end

    if (not lkItem) then
        lkItem = IngList.Compo[item]
    end

    if (lkItem) then
        print("lkItem "..lkItem.label)
        for ingredient, details in pairs(lkItem.ingredients) do    
            if(details.base)then                
                table.insert(ingredient,{label=IngList.Base[ingredient].label,amount=details.amount})  
            end

            if(not details.base)then   
                local lkIgd = lrec.Compo[item]
                if (not lkItem) then
                    lkItem = IngList.Compo[item]
                end

                if (lkItem) then
                    table.insert(ingredient,{label=lkItem.label.."(*)",amount=details.amount})  
                end

            end

            
        end

        for key, element in pairs(result) do
            TriggerClientEvent('ox_lib:notify', src, {type = 'info', description = element.amount.."x "..element.label,duration=5000,position='center-right'})
        end
        TriggerClientEvent('ox_lib:notify', src, {type = 'info', description = "Recette: "..lkItem.label ,duration=5000,position='center-right'})
    end
    
   
    return result
end

local function init()
    idCaisses ={}
    for index, restaurant in ipairs(Config.Restaurants) do
        initFidge(restaurant,index)
        initKitchen(restaurant,index)
        initCarte(restaurant,index)
        initManagement(restaurant,index)
    end
end

function initManagement(cfg,key)

    for index, caisse in pairs(cfg.Management) do
        local options = {}
        table.insert(options,{
            name = "ManagementPrice",  -- Nom de l'option, unique pour chaque interaction
            label = "Gestion des prix",  -- Texte affiché à l'utilisateur
            icon = 'fas fa-cogs',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                managePrice(cfg.Menu,cfg)
            end,
        });

        table.insert(options,{
            name = "ManagementRecipe",  -- Nom de l'option, unique pour chaque interaction
            label = "Gestion des recettes",  -- Texte affiché à l'utilisateur
            icon = 'fas fa-cogs',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                manageRecipe(cfg)
            end,
        });

        local idCaisse = exports.ox_target:addSphereZone({ 
            coords = caisse.coords,
            radius = caisse.size,
            debug = cfg.DebugMode,
            options = options   })  
    end

     

end

function initCarte(cfg,key)
    local options = {}

    for index, caisse in pairs(cfg.Carte) do
        local options = {}
        table.insert(options,{
            name = "carte",  -- Nom de l'option, unique pour chaque interaction
            label = caisse.title,  -- Texte affiché à l'utilisateur
            icon = 'fas fa-window-restore',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                lauchMenu(cfg,key)
            end,
        });

        table.insert(options,{
            name = "order",  -- Nom de l'option, unique pour chaque interaction
            label = "Caisse",  -- Texte affiché à l'utilisateur
            icon = 'fas fa-money-check',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()     
                print("key launchCaisse "..index)               
                launchCaisse(index,cfg,key)
            end,
            groups = cfg.Job,
        });

        table.insert(options,{
            name = "Pointeuse",  -- Nom de l'option, unique pour chaque interaction
            label = "Pointeuse",  -- Texte affiché à l'utilisateur
            icon = 'fas fa-clock',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                 
                clock(cfg.Job)
            end,
            groups = cfg.Job,
        });
        
        table.insert(options,{
            name = "plateau",  -- Nom de l'option, unique pour chaque interaction
            label = "Plateau",  -- Texte affiché à l'utilisateur
            icon = 'fas fa-archive',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                exports.ox_inventory:openInventory('stash', cfg.Job.."plateau"..index)
            end,
        });
        
        if(cfg.DebugMode) then
            table.insert(options,{
                name = "virtualfridge",  -- Nom de l'option, unique pour chaque interaction
                label = "virtualfridge",  -- Texte affiché à l'utilisateur
                icon = 'fa-solid fa-plate-utensils',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    exports.ox_inventory:openInventory('stash', cfg.Job.."virtualfridge")
                end,
            });
        end

        

        local idCaisse = exports.ox_target:addSphereZone({ 
            coords = caisse.coords,
            radius = caisse.size,
            debug = cfg.DebugMode,
            options = options   })    

        table.insert(idCaisses,{id=idCaisse,index = index, key=key})  
    end
end

-- Prépare et lance le menu
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
    local Recipe = getRecipe(cfg.Job)
        -- Parcourir les items et les assigner à leur catégorie
        for item, menu in pairs(cfg.Menu) do
            if menu.categorie == categorie.name then
                local label = item
                local limage = ""
                print("### item ### "..item)
                for recipeName, recipeData in pairs(Recipe.List) do
                    print('recipeName '..recipeName)
                    if recipeName == item then
                        -- Ajouter le couple itemname/label dans le tableau
                        label = recipeData.label
                        limage = recipeData.image
                        print("labvel "..label)
                    end
                end
                
                local itemData = {
                    Label = label, --exports.ox_inventory:Items()[item].label,
                    name = item,
                    price = menu.price,
                    image = limage
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

-- Prépare et lance la caisse (uniquement disponible pour les employés)
function launchCaisse(indexCaisse,cfg,key)
    print("indexCaisse "..indexCaisse)
    SetNuiFocus(true, true)
    local Menu = {}
    Menu.items = {}
    Menu.indexCaisse = indexCaisse
    Menu.key = key
    Menu.theme = "styles_"..cfg.Job..".css"
    Menu.cfg = cfg

       -- Parcourir les catégories dans l'ordre défini
   for _, categorie in ipairs(cfg.Categorie) do
    local categoryItems = {}
    local Recipe = getRecipe(cfg.Job)
        -- Parcourir les items et les assigner à leur catégorie
        for item, menu in pairs(cfg.Menu) do
            if menu.categorie == categorie.name then
                local label = item
                local limage = ""
                for recipeName, recipeData in pairs(Recipe.List) do
                    if recipeName == item then
                        -- Ajouter le couple itemname/label dans le tableau
                        label = recipeData.label
                        limage = recipeData.image
                    end
                end
                
                local itemData = {
                    Label = label, --exports.ox_inventory:Items()[item].label,
                    name = item,
                    price = menu.price,
                    image = limage
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
    print("order indexCaisse "..data.indexCaisse..' key '..data.key)
    local player = source
    local items = {}

    for _, item in ipairs(data.items) do
        table.insert(items, {
            name = item.name,
            label = item.label,
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
    -- Clé de config
    bill.key = data.key
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


function clock(job)
    local playerData = QBCore.Functions.GetPlayerData()
    if(playerData.job.name==job) then
        TriggerServerEvent('QBCore:ToggleDuty')
       -- QBCore.Functions.GetPlayerData().job.onduty
    end
end
-- Met à jour la caisse la plus proche pour ajouter l'option payer 
RegisterNetEvent('gm-restaurant:client:updateCarte')
AddEventHandler('gm-restaurant:client:updateCarte', function(bill,cfg)
    local idCaisse = nil
    local index 

    for i, v in ipairs(idCaisses) do
        if((v.index == bill.indexCaisse) and (v.key == bill.key))then
            index = i
            idCaisse = v.id 
        end
    end

    table.remove(idCaisses, index)    
    exports.ox_target:removeZone(idCaisse)
    Wait(10)

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
                icon = 'fas fa-money-check',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    createBill(bill,cfg)
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

            table.insert(idCaisses,{id=lidCaisse,index = key, key = bill.key})  
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
    end
    if(data.action == 'order')then
        order(data.param,data.cfg)
    end
    if (data.action == 'savePrices') then
        TriggerServerEvent('gm-restaurant:server:updatePrice', data.param.menu)
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


-- Pour les changements de prix
function managePrice(menu,cfg)
    local lrec = getRecipe(cfg.Job)

    local dataMenu = {}
    PrintTable(menu)
    for key, item in pairs(menu) do
        local lkItem = lrec.List[key]
        print(lkItem.label)
        table.insert(dataMenu,{label=lkItem.label,price=item.price,name=key})  
    end
    PrintTable(dataMenu)
    SetNuiFocus(true, true)
    local data = {}
    data.theme = "management_price.css"
    data.menu = dataMenu
    SendNUIMessage({
        action = 'managePrice',
        data = data, 
    })
end

-- Pour les recettes --
function genIngredientsCategory()
    local categories = {}
    local categoriesSet = {} -- Table pour stocker les catégories uniques

    for _, item in pairs(IngList.Base) do
        local cat = item.cat
        if cat and not categoriesSet[cat] then
            table.insert(categories, cat)  -- Ajouter la catégorie si elle n'est pas déjà présente
            categoriesSet[cat] = true      -- Marquer la catégorie comme ajoutée
        end
    end

    return categories
end

function manageRecipe(cfg)
    local Data = {}
    Data.recipe = {}
    Data.categoryIngredient = {}
    Data.categoryDish = {}
    Data.ingredient = {}
    Data.compo = {}

    Data.recipe = getRecipe(cfg.Job).List
    Data.ingredient = IngList.Base
    Data.categoryIngredient = genIngredientsCategory()
    Data.theme = "management_recipe.css"
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'manageRecipe',
        data = Data, 
    })
end



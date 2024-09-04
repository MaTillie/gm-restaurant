local QBCore = exports['qb-core']:GetCoreObject()
local sharedConfig = require 'config'
local idCaisses = {}

local function coordsEqual(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
end

local function init()
    for key, kitchen in pairs(Config.Kitchen) do
        local options = {}

        for _, item in ipairs(kitchen.items) do
            local formattedIngredients = {}
            --print("A1"..item)
            for ingredient, details in pairs(Config.Menu[item].ingredients) do
             --   print("P  " .. ingredient .. ": " .. details.amount)
                formattedIngredients[ingredient] = details.amount
            end

            table.insert(options,{
                name = item,  -- Nom de l'option, unique pour chaque interaction
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
                        TriggerServerEvent('gm-restaurant:server:craft',formattedIngredients,item)
                    else
                        print("Progress cancelled for: " .. item)
                    end                    
                end,
                groups = Config.Job,
                items = formattedIngredients,
            });
        end

        exports.ox_target:addSphereZone({ 
                coords = kitchen.coords,
                radius = kitchen.size,
                debug = Config.DebugMode,
                options = options                
            })
    end

    for key, kitchen in pairs(Config.Fridge) do
        local options = {}

        for _, item in ipairs(kitchen.items) do
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
                    else
                        print("Progress cancelled for: " .. item)
                    end
                end,
                groups = Config.Job,
            });

                       
        end
        exports.ox_target:addSphereZone({ 
            coords = kitchen.coords,
            radius = kitchen.size,
            debug = Config.DebugMode,
            options = options                
        }) 
    end   

    initCarte()
    
end

function initCarte()
    local options = {}
    idCaisses ={}

    for key, caisse in pairs(Config.Carte) do
        local options = {}
        table.insert(options,{
            name = "carte",  -- Nom de l'option, unique pour chaque interaction
            label = caisse.title,  -- Texte affiché à l'utilisateur
            icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                lauchMenu()
            end,
        });

        table.insert(options,{
            name = "order",  -- Nom de l'option, unique pour chaque interaction
            label = "Caisse",  -- Texte affiché à l'utilisateur
            icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                launchCaisse()
            end,
            groups = Config.Job,
        });


        local idCaisse = exports.ox_target:addSphereZone({ 
            coords = caisse.coords,
            radius = caisse.size,
            debug = Config.DebugMode,
            options = options   })    

        table.insert(idCaisses,{id=idCaisse,coords = caisse.coords})  
    end
end



function lauchMenu()
  SetNuiFocus(true, true)
  local Menu = {}
  Menu =Config.Menu
  for key, menu in pairs(Menu) do
    menu.Label = exports.ox_inventory:Items()[key].label
  end

    SendNUIMessage({
        action = 'openMenu',
        toggle = true,
        data = Config.Menu
    })

end

function launchCaisse()
    SetNuiFocus(true, true)
    local Menu = {}
    Menu =Config.Menu
    for key, menu in pairs(Menu) do
      menu.Label = exports.ox_inventory:Items()[key].label
    end
  
      SendNUIMessage({
          action = 'openOrder',
          toggle = true,
          data = Config.Menu
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
    local bill ={}

    local playerData = QBCore.Functions.GetPlayerData()

    local billFrom = {
        citizen = playerData.citizenid,
        name = playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname,
        job = playerData.job.name,
    }

    local description = ""
    local amount = 0.0
    for _, item in ipairs(data) do
        description = description..item.label.." x"..item.quantity..", "
        amount = amount + item.quantity * item.price
    end    

    bill.referance = createReference()
    bill.title = Config.invoiceWording
    bill.description = description
    bill.billFrom = billFrom
    bill.amount = amount 
    bill.status = "unpaid"
    bill.type = "compagny"
    bill.date = GetClockYear().."-"..GetClockMonth().."-"..GetClockDayOfMonth()
    local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] = GetLocalTime()
    local msg = "date : "..year.."-"..month.."-"..day
    exports.qbx_core:Notify(msg, "inform",10000,"",'center-right')
    -- identification de la caisse la plus proche 
    local dist = 10000
    local coords 
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for key, caisse in pairs(Config.Carte) do
        local ldist = #(caisse.coords - pos)
        if(ldist<dist)then
            dist = dist
            coords = caisse.coords
        end
    end

    bill.coords = coords

    
    TriggerServerEvent('gm-restaurant:server:order',bill)   
end

-- Met à jour la caisse la plus proche pour ajouter l'option payer 
RegisterNetEvent('gm-restaurant:client:updateCarte')
AddEventHandler('gm-restaurant:client:updateCarte', function(bill)
    print("updateCarte")
    local idCaisse = nil
    print("billx "..bill.coords.x)
    for _, item in ipairs(idCaisses) do
        if(coordsEqual(item.coords , bill.coords))then
            idCaisse = item.id 
        end
    end   

    local index 

    for i, v in ipairs(idCaisses) do
        if(v.coords == bill.coords)then
            index = i
        end
    end

    table.remove(idCaisses, index)
    exports.ox_target:removeZone(idCaisse)


    for key, caisse in pairs(Config.Carte) do
        if(coordsEqual(caisse.coords,bill.coords))then
            print("updateCarte égale")
            local options = {}
            table.insert(options,{
                name = "carte",  -- Nom de l'option, unique pour chaque interaction
                label = caisse.title,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    lauchMenu()
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
                    launchCaisse()
                end,
                groups = Config.Job,
            });


            local lidCaisse = exports.ox_target:addSphereZone({ 
                coords = caisse.coords,
                radius = caisse.size,
                debug = Config.DebugMode,
                options = options   })    

            table.insert(idCaisses,{id=lidCaisse,coords = caisse.coords})  
        end
    end


end)

function createBill(bill)
    print("bill")
    local msg = "La  facture vient de vous être émise. Utilisez votre application de paiement favorite."
    exports.qbx_core:Notify(msg, "inform",10000,"",'center-right')
    local playerData = QBCore.Functions.GetPlayerData()

    local billTo = {
        citizen = playerData.citizenid,
        name = playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname,
    }
    bill.billTo = billTo
    

    TriggerServerEvent('gm-restaurant:server:createBill',bill)  
    --TriggerServerEvent('dusa_billing:sv:createCustomInvoice',playerData.citizenid, bill.title,bill.description ,bill.amount,"compagny")  
    TriggerServerEvent('gm-restaurant:server:payment',bill)   
    
end

-- Gestion du NUI Callback
RegisterNUICallback('nuiCallback', function(data, cb)
    if data.action == 'closeMenu' then
        closeMenu()  -- Appelle la fonction Lua avec le paramètre envoyé depuis JS
    else if(data.action == 'order')then
    end
        order(data.param)
    end

    cb('ok')  -- Réponse à envoyer au JS
end)

function createReference()
    local result = ''
    local characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local charactersLength = string.len(characters)
    local counter = 0

    while counter < 7 do
        local randomIndex = math.random(1, charactersLength)
        result = result .. string.sub(characters, randomIndex, randomIndex)
        counter = counter + 1
    end

    return "HOG"..result
end


RegisterNetEvent('gm-restaurant:client:updateCartePayed')
AddEventHandler('gm-restaurant:client:updateCartePayed', function(bill)
    print("updateCarte")
    local idCaisse = nil
    print("billx "..bill.coords.x)
    for _, item in ipairs(idCaisses) do
        if(coordsEqual(item.coords , bill.coords))then
            idCaisse = item.id 
        end
    end   

    local index 

    for i, v in ipairs(idCaisses) do
        if(v.coords == bill.coords)then
            index = i
        end
    end

    table.remove(idCaisses, index)
    exports.ox_target:removeZone(idCaisse)

    for key, caisse in pairs(Config.Carte) do
        if(coordsEqual(caisse.coords,bill.coords))then
            print("updateCarte égale")
            local options = {}
            table.insert(options,{
                name = "carte",  -- Nom de l'option, unique pour chaque interaction
                label = caisse.title,  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    lauchMenu()
                end,
            });

            table.insert(options,{
                name = "order",  -- Nom de l'option, unique pour chaque interaction
                label = "Caisse",  -- Texte affiché à l'utilisateur
                icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
                onSelect = function()                    
                    launchCaisse()
                end,
                groups = Config.Job,
            });


            local lidCaisse = exports.ox_target:addSphereZone({ 
                coords = caisse.coords,
                radius = caisse.size,
                debug = Config.DebugMode,
                options = options   })    

            table.insert(idCaisses,{id=lidCaisse,coords = caisse.coords})  
        end
    end


end)
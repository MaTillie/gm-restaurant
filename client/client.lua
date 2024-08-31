--exports.ox_target:addSphereZone(parameters)
local sharedConfig = require 'config'

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
                        TriggerServerEvent('gm-restaurant:craft',formattedIngredients,item)
                        menu()
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
                        TriggerServerEvent('gm-restaurant:craft',{},item)                                              
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

    local options = {}
    for key, caisse in pairs(Config.Carte) do
        local options = {}
        table.insert(options,{
            name = "carte",  -- Nom de l'option, unique pour chaque interaction
            label = caisse.title,  -- Texte affiché à l'utilisateur
            icon = 'fas fa-coffee',  -- Icône affichée à côté de l'option (utilise FontAwesome)
            onSelect = function()                    
                menu()
            end,
        });


        exports.ox_target:addSphereZone({ 
            coords = caisse.coords,
            radius = caisse.size,
            debug = Config.DebugMode,
            options = options   })    
    end
    
end

function menu()
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

RegisterNetEvent('gm-restaurant:client:menu')
AddEventHandler('gm-restaurant:client:menu', function(prm)
    SendNUIMessage({
        action = 'openMeter',
        toggle = true,
        meterData = 5
    })
end)



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

-- Gestion du NUI Callback
RegisterNUICallback('nuiCallback', function(data, cb)
    if data.action == 'closeMenu' then
        closeMenu()  -- Appelle la fonction Lua avec le paramètre envoyé depuis JS
    end

    cb('ok')  -- Réponse à envoyer au JS
end)
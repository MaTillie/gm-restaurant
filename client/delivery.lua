local currentOrder = nil
local currentDelivery = nil
local pedModel = 'mp_f_forgery_01' -- Modèle du PNJ (remplace par le modèle que tu souhaites utiliser)
local orderCompleted = false

-- Charger le modèle du PNJ
function loadPedModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(100)
    end
end

-- Création du PNJ avec le modèle spécifique et ajout à ox_target
Citizen.CreateThread(function()
    -- Charger le modèle du PNJ
    loadPedModel(pedModel)

    -- Positionner le PNJ sur la carte
    local pnjCoords = Config.NPCCoords
    local ped = CreatePed(4, pedModel, pnjCoords.x, pnjCoords.y, pnjCoords.z - 1.0, Config.NPCHeading, false, true)
    SetEntityHeading(ped, 90.0) -- Orienter le PNJ
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    -- Utiliser ox_target pour interagir avec ce modèle de PNJ
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'delivery:start',
            event = 'gm-restaurant:client:delivery:requestOrder',
            icon = 'fa-solid fa-box',
            label = 'Prendre une commande',
            canInteract = function(entity, distance, coords)
                return not currentOrder -- Seulement si aucune commande n'est en cours
            end
        },
        {
            name = 'delivery:validate',
            event = 'gm-restaurant:client:delivery:validateOrder',
            icon = 'fa-solid fa-box-check',
            label = 'Valider la commande',
            canInteract = function(entity, distance, coords)
                return currentOrder and hasAllItems() -- Si le joueur a tous les items nécessaires
            end
        },
        {
            name = 'delivery:finish',
            event = 'gm-restaurant:client:delivery:finishOrder',
            icon = 'fa-solid fa-coins',
            label = 'Toucher sa prime',
            canInteract = function(entity, distance, coords)
                return currentOrder and orderCompleted -- Si le joueur a terminé la livraison
            end
        },
    })
end)

-- Interaction avec le PNJ pour récupérer la commande
RegisterNetEvent('gm-restaurant:client:delivery:requestOrder')
AddEventHandler('gm-restaurant:client:delivery:requestOrder', function()
    if currentOrder then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'Vous avez déjà une commande en cours !'})
        return
    end

    local order = {}
    local itemCount = math.random(3, 10)

    local MenuDispo = {}
    local count=0

    while (count< 15) do
        for key, item in ipairs(Config.Menu) do
            if (item.menu and (count< 15)) then
                if (math.random(1, 10)>5) then
                    local lamount = math.random(1, 4)
                    count = count + lamount
                    table.insert(order,{name=key,amount=lamount, price = lamount*item.price})
                end
            end
        end
    end

    

    for i = 1, itemCount do
        local rdmIdx = math.random(1, index)
        local randomItem
        for key, item in ipairs(MenuDispo) do
            if (item.index == rdmIdx)then
                randomItem = MenuDispo[rdmIdx]
            end
        end
        
        for j =1, #order do
            if(oreder[j])
        end
        table.insert(order, randomItem)
    end
    orderCompleted = false
    currentOrder = order
    TriggerEvent('ox_lib:notify', {type = 'success', description = 'Vous avez reçu une commande, récupérez les items nécessaires.'})
end)

-- Vérification si le joueur possède tous les items requis
function hasAllItems()
    -- Remplace cette fonction par la vérification réelle des items dans l'inventaire du joueur
    for _, item in ipairs(currentOrder) do
        if not PlayerHasItem(item) then
            return false
        end
    end
    return true
end

-- Validation de la commande
RegisterNetEvent('gm-restaurant:client:delivery:validateOrder')
AddEventHandler('gm-restaurant:client:delivery:validateOrder', function()
    if not currentOrder then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'Aucune commande en cours.'})
        return
    end

    if hasAllItems() then
        local randomDelivery = Config.Delivery[math.random(#Config.Delivery)]
        currentDelivery = randomDelivery

        -- Création du marqueur et du trajet
        SetNewWaypoint(currentDelivery.coords.x, currentDelivery.coords.y)
        TriggerEvent('ox_lib:notify', {type = 'success', description = 'Tous les items sont récupérés, direction la destination.'})

        -- Affichage d'un marqueur visuel pour la livraison
        local blip = AddBlipForCoord(currentDelivery.coords.x, currentDelivery.coords.y, currentDelivery.coords.z)
        SetBlipSprite(blip, 1) -- Blip bleu
        SetBlipRoute(blip, true)
        SetBlipColour(blip, 3)
        currentDelivery.blip = blip
    else
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'Il vous manque des items pour compléter la commande.'})
    end
end)

-- Vérification pour la validation de la livraison à destination
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if currentDelivery and IsPlayerNearCoords(currentDelivery.coords) and not orderCompleted then
            DrawText3D(currentDelivery.coords.x, currentDelivery.coords.y, currentDelivery.coords.z, "[E] Valider la livraison")

            if IsControlJustPressed(0, 38) then -- Touche E
                orderCompleted = true
                RemoveBlip(currentDelivery.blip)    
                exports.qbx_core:Notify("Livraison effectuée, retournez voir Monique", "inform",10000,"",'center-right')
            end
        end
    end
end)

RegisterNetEvent('gm-restaurant:client:delivery:finishOrder')
AddEventHandler('gm-restaurant:client:delivery:finishOrder', function()
    
    currentOrder = nil
    orderCompleted = false
end)

-- Fonction pour vérifier si le joueur est proche de coordonnées données (utile pour la livraison)
function IsPlayerNearCoords(coords)
    local playerCoords = GetEntityCoords(PlayerPedId())
    return #(playerCoords - coords) < 5.0 -- Proximité de 5 unités
end

-- Fonction pour afficher du texte 3D à l'écran
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(1)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

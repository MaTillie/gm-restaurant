local QBCore = exports['qb-core']:GetCoreObject()

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
        exports.ox_inventory:AddItem(src, item, 1)
    end

end)	



RegisterNetEvent('gm-restaurant:server:order')
AddEventHandler('gm-restaurant:server:order', function(bill)
    local src = source 
    print("server order")
    TriggerClientEvent('gm-restaurant:client:updateCarte', src,bill)  
end)

RegisterNetEvent('gm-restaurant:server:createBill')
AddEventHandler('gm-restaurant:server:createBill', function(data)
    print("Create bills")
    MySQL.Async.execute('INSERT INTO dusa_bills (reference, title, description, billFrom, billTo, amount, status, type, date) VALUES (@reference, @title, @description, @billFrom, @billTo, @amount, @status, @type, @date)',
    {
        ['@reference']   = data.referance,
        ['@title']   = data.title,
        ['@description']   = data.description,
        ['@billFrom']   = json.encode(data.billFrom),
        ['@billTo']   = json.encode(data.billTo),
        ['@amount'] = data.amount,
        ['@status']   = data.status,
        ['@type']   = data.type,
        ['@date']   = data.date,
    }, function (rowsChanged)
        bills = MySQL.prepare.await('SELECT * FROM dusa_bills', {})
        -- PrintTable(bills)
    end)
end)

RegisterNetEvent('gm-restaurant:server:payment')
AddEventHandler('gm-restaurant:server:payment', function(bill)
    local src = source 
    print("server order")
    TriggerClientEvent('gm-restaurant:client:updateCartePayed', src,bill)  
end)


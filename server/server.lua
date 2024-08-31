RegisterNetEvent('gm-restaurant:craft')
AddEventHandler('gm-restaurant:craft', function(ingredients,item)	
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

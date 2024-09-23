function stock(exist)
    if(not exist)then
        exist = false
    end

    local result = {}
    
    for ingredient, details  in pairs(IngList.Base) do
        local metadata ={
            label = details.label,
        }
        local count = exports.ox_inventory:GetItemCount(VirtualFridgeName(), "leap_ingredient",metadata)
        local flg = false

        if(exist)then
            flg = count>0
        else
            flg = true
        end

        if flg then
            table.insert(result, {
                name = ingredient,
                amount = count,
                label = details.label,
            })
        end
    end
    return result   
end

function getIngredients(name,base,amount)
    
end

-- Commande : {name,amount}


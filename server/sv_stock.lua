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

function getIngredients(name,cfg,base,amount)
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
        
        for ingredient, details in pairs(lkItem.ingredients) do    
            if(details.base)then     
                result[ingredient] = {label=IngList.Base[ingredient].label,amount=details.amount}          
                --table.insert(result,{label=IngList.Base[ingredient].label,amount=details.amount})  
            end

            if(not details.base)then   
                local resIgd = {}
                resIgd = getIngredients(ingredient,cfg,false,details.amount)
                
                for igd, det in pairs(resIgd) do   
                    if(result[igd])then
                        result[igd].amount = result[igd].amout + det.amount
                    else
                        result[igd] = {label=igd.label,amount=digd.amount}   
                    end
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




-- Commande : {name,amount}


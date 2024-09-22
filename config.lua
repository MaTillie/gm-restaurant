Config = {
    Restaurants = {
        [1] = getConfig_hogspub(),
       -- [2] = getConfig_towngrill(),        
    },
    Recipes ={
        ["hogspub"] = getRecipe_hogspub(),
    }
}

function getRecipe(job)
    print("getRecipe "..job)
    if(job == "hogspub") then
        return getRecipe_hogspub()
    end
end
Config = {
    Restaurants = {
        [1] = getConfig_hogspub(),
       -- [2] = getConfig_jopizza(),        
    },
    Recipes ={
        ["hogspub"] = getRecipe_hogspub(),
        ["jopizza"] = getRecipe_jopizza(),        
    },

    NPC = {
        pos = vec3(926.0, -2436.85, 28.46),
        heading = 137.98,
        model = 'a_m_m_farmer_01',
    }
}

function getRecipe(job)
    print("getRecipe "..job)
    if(job == "hogspub") then
        return getRecipe_hogspub()
    end
    if(job == "jopizza") then
        return getRecipe_jopizza()
    end
    
end
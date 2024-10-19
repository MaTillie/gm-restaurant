Config = {
    Restaurants = {
        [1] = getConfig_hogspub(),
        [2] = getConfig_jopizza(),        
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



--## Delivery ##--

Config.NPCCoords = vec3(-594.76, -285.07, 35.45)
Config.NPCHeading = 227.13

Config.Delivery = {
    Coords = {
        vec3(-639.91, 296.93, 82.46),
        vec3(-1221.67, -329.82, 37.55),
        vec3(-668.19, -971.63, 22.34),
    },
    NPCCoords = vec3(-594.76, -285.07, 35.45),
    NPCHeading = 227.13,
}
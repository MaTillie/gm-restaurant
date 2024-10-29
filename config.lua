Config = {
    Restaurants = {
        [1] = getConfig_hogspub(),
        [2] = getConfig_jopizza(),        
        [3] = getConfig_leapfrog(),   
    },
    Recipes ={
        ["hogspub"] = getRecipe_hogspub(),
        ["jopizza"] = getRecipe_jopizza(),        
        ["leapfrog"] = getRecipe_leapfrog(),     
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
    if(job == "leapfrog") then
        return getRecipe_leapfrog()
    end      
end

function getConfig(job)
    print("getRecipe "..job)
    if(job == "hogspub") then
        return getConfig_hogspub()
    end
    if(job == "jopizza") then
        return getConfig_jopizza()
    end
    if(job == "leapfrog") then
        return getConfig_leapfrog()
    end      
    return nil
end




--## Delivery ##--
Config.Locations = {
    vec4(257.61, -380.57, 44.71, 340.5),
    vec4(-48.58, -790.12, 44.22, 340.5),
    vec4(240.06, -862.77, 29.73, 341.5),
    vec4(826.0, -1885.26, 29.32, 81.5),
    vec4(350.84, -1974.13, 24.52, 318.5),
    vec4(-229.11, -2043.16, 27.75, 233.5),
    vec4(-1053.23, -2716.2, 13.75, 329.5),
    vec4(-774.04, -1277.25, 5.15, 171.5),
    vec4(-1184.3, -1304.16, 5.24, 293.5),
    vec4(-1321.28, -833.8, 16.95, 140.5),
    vec4(-1613.99, -1015.82, 13.12, 342.5),
    vec4(-1392.74, -584.91, 30.24, 32.5),
    vec4(-515.19, -260.29, 35.53, 201.5),
    vec4(-760.84, -34.35, 37.83, 208.5),
    vec4(-1284.06, 297.52, 64.93, 148.5),
    vec4(-808.29, 828.88, 202.89, 200.5),
}

Config.FoodPreset = {
    ["gmr_plat"] = {
        label = "Plat",  
        alcool= 0,
        stats ={
            hunger = -50,
            thirst = 5,
            energy = 8,
            stress = -3,
            poop = 5,
            hygiene = -3,
        },
    },
    ["gmr_petitplat"] = {
        label = "Entrée/Dessert/Side",
        alcool= 0,
        stats ={
            hunger = -25,
            thirst = 5,
            energy = 4,
            stress = -3,
            poop = 5,
            hygiene = -3,
        }
    },    
    ["gmr_boisson"] = {
        label = "Soft",
        alcool= 0,
        stats ={
            hunger = 0,
            thirst = -50,
            energy = 10,
            stress = -10,
            pee = 10,
            hygiene = -5,
        }
    },
    ["gmr_alcoolbiere"] = {
        label = "Alcool type bière",
        alcool= 10,
        stats ={
            hunger = 0,
            thirst = -20,
            energy = -5,
            stress = -20,
            pee = 15,
            hygiene = -5,
        },
    },
    ["gmr_alcoolverrevin"] = {
        label = "Alcool type verre de vin",
        alcool= 10,
        stats ={
            hunger = 0,
            thirst = -20,
            energy = 5,
            stress = -10,
            pee = 5,
            hygiene = -5,
        }
    },
    ["gmr_alcoolfort"] = {
        label = "Alcool fort",
        alcool= 25,
        stats = {
            hunger = 0,
            thirst = -10,
            energy = -10,
            stress = -10,
            pee = 5,
            hygiene = -5,
        }
    },
}

Config.Animation ={
        ["pizza_01"] = {
            label="Pizza",
			model = `knjgh_pizzaslice1`,
			position = {
				bone = 0x49D9,
				offset = {
					pos = vector3(0.11, 0.02, -0.02),
					rot = vector3(0.0, 90.0, 0.0),
				},
			},
		},
        ["burger_01"]={
            label = "Burger",
            model = `prop_cs_burger_01`,
			position = {
				bone = 0x49D9,
				offset = {
					pos = vector3(0.11, 0.02, -0.02),
					rot = vector3(0.0, 0.0, 0.0),
				},
			},
        },
        ["sandwich_01"]={
            label = "Sandwich",
            model = `prop_sandwich_01`,
			position = {
				bone = 0x49D9,
				offset = {
					pos = vector3(0.11, 0.02, -0.02),
					rot = vector3(0.0, 0.0, 0.0),
				},
			},
        },
        ["beer_01"]  = {
            label = "Bière",
            model = `prop_beer_pissh`,
            position = {
                bone = 0xeb95,
                offset = {
                    pos = vector3(0.0, 0.0, -0.05),
                    rot = vector3(0.0, 0.0, -40.0),
                },
            },
        },
        ["soda_01"]  = {
            label = "Soda",
            model = `prop_beer_pissh`,
            position = {
                bone = 0xeb95,
                offset = {
                    pos = vector3(0.0, 0.0, -0.05),
                    rot = vector3(0.0, 0.0, -40.0),
                },
            },
        },
        ["cafe_01"]  = {
            label = "Café",
            model = `prop_beer_pissh`,
            position = {
                bone = 0xeb95,
                offset = {
                    pos = vector3(0.0, 0.0, -0.05),
                    rot = vector3(0.0, 0.0, -40.0),
                },
            },
        },
        ["glasse_01"]  = {
            label = "Verre",
            model = `prop_beer_pissh`,
            position = {
                bone = 0xeb95,
                offset = {
                    pos = vector3(0.0, 0.0, -0.05),
                    rot = vector3(0.0, 0.0, -40.0),
                },
            },
        },

}
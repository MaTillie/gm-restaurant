function getRecipe_hogspub()
Recipes = {}

Recipes.List = {
    ["gmr_dsh_hogspub_fishnchips"] = {
        categorie = "plat",
        label = "Fish and chips",
        ingredients = {
            ["gmr_igd_cabillaud"] = {amount = 1, base = true},
            ["gmr_cpigd_frites"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_cpigd_bechamel"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_igd_sel"] = {amount = 1, base = true},
            ["gmr_igd_poivre"] = {amount = 1, base = true},
        },
    },
    
    ["gmr_dsh_hogspub_chocogrenouille"] = {
        categorie = "petitplat",
        label = "Chocogrenouille",
        ingredients = {
            ["gmr_igd_chocolat"] = {amount = 3, base = true},
            ["gmr_igd_beurre"] = {amount = 1, base = true},
            ["gmr_igd_sucre"] = {amount = 1, base = true},
            ["gmr_igd_oeuf"] = {amount = 1, base = true},
        },
    },
    
    ["gmr_dsh_hogspub_bubblensqueak"] = {
        categorie = "plat",
        label = "Bubble and squeak",
        ingredients = {
            ["gmr_cpigd_puree_de_pomme"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_igd_chou"] = {amount = 1, base = true},
            ["gmr_igd_oignon"] = {amount = 1, base = true},
            ["gmr_igd_bacon"] = {amount = 2, base = true},
            ["gmr_igd_beurre"] = {amount = 1, base = true},
        },
    },
    
    ["gmr_dsh_hogspub_chickenpie"] = {
        categorie = "plat",
        label = "Chiken pie",
        ingredients = {
            ["gmr_cpigd_pate_feuilletee"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_igd_poulet"] = {amount = 2, base = true},
            ["gmr_cpigd_sauce_bolognaise"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_igd_oeuf"] = {amount = 1, base = true},
            ["gmr_igd_sel"] = {amount = 1, base = true},
            ["gmr_igd_poivre"] = {amount = 1, base = true},
        },
    },
    
    ["gmr_dsh_hogspub_bierraubeurre"] = {
        categorie = "alcoolbiere",
        label = "Bierraubeure",
        ingredients = {
            ["gmr_igd_biere"] = {amount = 1, base = false},  -- nouvel ingrédient de base
            ["gmr_igd_beurre"] = {amount = 1, base = true},
            ["gmr_igd_sucre"] = {amount = 1, base = true},
            ["gmr_igd_vanille"] = {amount = 1, base = true},
        },
    },
    
    ["gmr_dsh_hogspub_polynectar"] = {
        categorie = "boisson",
        label = "Polynectar",
        ingredients = {
            ["gmr_igd_herbes_magiques"] = {amount = 1, base = false},  -- nouvel ingrédient de base
            ["gmr_igd_eau"] = {amount = 1, base = true},
            ["gmr_igd_poivre"] = {amount = 1, base = true},
            ["gmr_igd_sel"] = {amount = 1, base = true},
        },
    },
    
    ["gmr_dsh_hogspub_jus_de_citrouille"] = {
        categorie = "boisson",
        label = "Jus de citrouille",
        ingredients = {
            ["gmr_igd_citrouille"] = {amount = 2, base = false},  -- nouvel ingrédient de base
            ["gmr_igd_sucre"] = {amount = 1, base = true},
            ["gmr_igd_eau"] = {amount = 1, base = true},
        },
    },
    
    -- New --
    ["gmr_dsh_hogspub_felix_felicis"] = {
        categorie = "boisson",
        label = "Potion de Felix Felicis",
        ingredients = {
            ["gmr_igd_herbes_magiques"] = {amount = 1, base = false},  -- nouvel ingrédient
            ["gmr_igd_miel"] = {amount = 1, base = true},
            ["gmr_igd_eau"] = {amount = 1, base = true},
            ["gmr_igd_orange"] = {amount = 1, base = true},
        },
    },
    ["gmr_dsh_hogspub_tartelette_citrouille"] = {
        categorie = "dessert",
        label = "Tartelette à la citrouille",
        ingredients = {
            ["gmr_cpigd_pate_sablee"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_igd_citrouille"] = {amount = 2, base = true},
            ["gmr_igd_sucre"] = {amount = 1, base = true},
            ["gmr_igd_cannelle"] = {amount = 1}, base = true,
            ["gmr_igd_oeuf"] = {amount = 1, base = true},
        },
    },
    ["gmr_dsh_hogspub_bierraubeurre_glacee"] = {
        categorie = "boisson",
        label = "Bierraubeure glacée",
        ingredients = {
            ["gmr_igd_biere"] = {amount = 1, base = false},  -- ingrédient de base
            ["gmr_igd_sucre"] = {amount = 1, base = true},
            ["gmr_igd_beurre"] = {amount = 1, base = true},
            ["gmr_cpigd_creme_fraiche"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_igd_vanille"] = {amount = 1, base = true},
            ["gmr_cpigd_glace"] = {amount = 1},  -- nouvel ingrédient
        },
    },
    ["gmr_dsh_hogspub_soupe_chicaneur"] = {
        categorie = "plat",
        label = "Soupe du Chicaneur",
        ingredients = {
            ["gmr_cpigd_fond_soupe"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_igd_poireau"] = {amount = 2, base = true},
            ["gmr_igd_carotte"] = {amount = 2, base = true},
            ["gmr_igd_pomme_de_terre"] = {amount = 2, base = true},
            ["gmr_igd_herbes_magiques"] = {amount = 1, base = true},
        },
    },
    ["gmr_dsh_hogspub_gateau_poudlard"] = {
        categorie = "dessert",
        label = "Gâteau de Poudlard",
        ingredients = {
            ["gmr_igd_farine"] = {amount = 3, base = true},
            ["gmr_igd_sucre"] = {amount = 2, base = true},
            ["gmr_igd_oeuf"] = {amount = 3, base = true},
            ["gmr_igd_beurre"] = {amount = 2, base = true},
            ["gmr_igd_chocolat"] = {amount = 3, base = true},
            ["gmr_cpigd_coulis_fruit"] = {amount = 1, base = false},  -- ingrédient intermédiaire
        },
    },
    ["gmr_dsh_hogspub_the_sortilege"] = {
        categorie = "boisson",
        label = "Thé au Sortilège",        
        ingredients = {
            ["gmr_igd_the"] = {amount = 1, base = false},  -- nouvel ingrédient
            ["gmr_igd_herbes_magiques"] = {amount = 1, base = true},
            ["gmr_igd_miel"] = {amount = 1, base = true},
            ["gmr_igd_eau"] = {amount = 1, base = true},
        },
    },
    ["gmr_dsh_hogspub_tartelette_caramel_magique"] = {
        categorie = "dessert",
        label = "Tartelette au caramel magique",
        ingredients = {
            ["gmr_cpigd_pate_sablee"] = {amount = 1, base = false},  -- ingrédient intermédiaire
            ["gmr_cpigd_caramel_magique"] = {amount = 2, base = true},
            ["gmr_igd_sucre"] = {amount = 1, base = true},
            ["gmr_igd_cannelle"] = {amount = 1, base = true},
            ["gmr_igd_oeuf"] = {amount = 1, base = true},
        },
    },
}

Recipes.Compo = {
    ["gmr_cpigd_caramel_magique"] = {
        description = "Caramel magique",
        dose = 4,  -- pour 4 portions
        ingredients = {
            ["gmr_igd_sucre"] = {amount = 3, base = true},
            ["gmr_igd_eau"] = {amount = 1, base = true},
            ["gmr_igd_herbes_magiques"] = {amount = 1, base = true},
        },
    },
}

return Recipes
end
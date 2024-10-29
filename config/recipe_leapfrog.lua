function getRecipe_leapfrog()
Recipes = {}

Recipes.List = {
    ["gmr_dsh_new_recipe_1729934268203"] = { 
              categorie = "gmr_plat",
              label = "talojjd",
              image = "",
              ingredients = {
                        ["gmr_igd_anguille"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1729933491473"] = { 
              categorie = "gmr_boisson",
              label = "Jus de citrouille",
              image = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/gmr_dsh_hogspub_jus_de_citrouille.png",
              ingredients = {
                        ["gmr_igd_eau"] = {amount = 1},
                        ["gmr_igd_miel"] = {amount = 1},
                        ["gmr_igd_citrouille"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1729934123322"] = { 
              categorie = "gmr_plat",
              label = "Ticalo",
              image = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/gmr_dsh_hogspub_jus_de_citrouille.png",
              ingredients = {
                        ["gmr_igd_calmar"] = {amount = 1},
                        ["gmr_igd_crevette"] = {amount = 1},
              },
    },
    ["gmr_cpigd_caramel_magique"] = { 
              categorie = "gmr_plat",
              label = "Caramel magique",
              image = "",
              ingredients = {
                        ["gmr_igd_eau"] = {amount = 1},
                        ["gmr_igd_sucre"] = {amount = 3},
                        ["gmr_igd_herbes_magiques"] = {amount = 1},
              },
    },
}

Recipes.Compo = {
}

return Recipes
end
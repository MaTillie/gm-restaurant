function getRecipe_jopizza()
Recipes = {}

Recipes.List = {
    ["gmr_dsh_new_recipe_1729933491473"] = { 
              categorie = "gmr_boisson",
              label = "Jus de citrouille",
              image = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/gmr_dsh_hogspub_jus_de_citrouille.png",
              props = "pizza_01",
              editable = true,
              ingredients = {
                        ["gmr_igd_citrouille"] = {amount = 1},
                        ["gmr_igd_miel"] = {amount = 1},
                        ["gmr_igd_eau"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730117891863"] = { 
              categorie = "gmr_alcoolfort",
              label = "Du pouette ",
              image = "",
              props = "beer_01",
              editable = true,
              ingredients = {
                        ["gmr_igd_cavatappi"] = {amount = 1},
                        ["gmr_igd_penne"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1729934123322"] = { 
              categorie = "gmr_boisson",
              label = "Ticalo2",
              image = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/gmr_dsh_hogspub_jus_de_citrouille.png",
              props = "burger_01",
              editable = true,
              ingredients = {
                        ["gmr_igd_crevette"] = {amount = 1},
                        ["gmr_igd_calmar"] = {amount = 1},
              },
    },
    ["gmr_cpigd_caramel_magique"] = { 
              categorie = "gmr_plat",
              label = "Caramel magique",
              image = "",
              props = "pizza_01",
              editable = true,
              ingredients = {
                        ["gmr_igd_eau"] = {amount = 1},
                        ["gmr_igd_herbes_magiques"] = {amount = 1},
                        ["gmr_igd_sucre"] = {amount = 3},
              },
    },
    ["gmr_dsh_new_recipe_1729934268203"] = { 
              categorie = "gmr_plat",
              label = "talojjd",
              image = "",
              props = "pizza_01",
              editable = true,
              ingredients = {
                        ["gmr_cpigd_caramel_magique"] = {amount = 1},
              },
    },
}

Recipes.Compo = {
}

return Recipes
end
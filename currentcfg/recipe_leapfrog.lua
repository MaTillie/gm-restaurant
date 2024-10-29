function getRecipe_leapfrog()
Recipes = {}

Recipes.List = {
    ["gmr_dsh_new_recipe_1730163243268"] = { 
              categorie = "gmr_petitplat",
              label = "Croissant au Beurre",
              image = "https://cdn.discordapp.com/attachments/839525646946140161/1300623561937129578/Croissant.png?ex=67218395&is=67203215&hm=05194c4971e9dcb4b4a3c2f0f608d4022d2a52d797fe471306a0fa4833b9f8d5&",
              props = "burger_01",
              amount = 1,
              editable = true,
              ingredients = {
                        ["gmr_dsh_new_recipe_1730161117917"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730057990443"] = { 
              categorie = "gmr_plat",
              label = "Muffin au myrtille",
              image = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/leap_muffin_myrtille.png",
              props = "pizza_01",
              amount = 1,
              editable = true,
              ingredients = {
                        ["gmr_igd_myrtille"] = {amount = 1},
                        ["gmr_dsh_new_recipe_1730057236503"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730057881877"] = { 
              categorie = "gmr_plat",
              label = "Pâte à pain",
              image = "",
              props = "pizza_01",
              amount = 1,
              editable = false,
              ingredients = {
                        ["gmr_igd_sel"] = {amount = 1},
                        ["gmr_igd_eau"] = {amount = 1},
                        ["gmr_igd_levure"] = {amount = 1},
                        ["gmr_igd_farine"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730057741279"] = { 
              categorie = "gmr_plat",
              label = "Muffin au chocolat",
              image = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/leap_muffin_chocolat.png",
              props = "pizza_01",
              amount = 1,
              editable = true,
              ingredients = {
                        ["gmr_igd_chocolat"] = {amount = 1},
                        ["gmr_dsh_new_recipe_1730057741279"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730059630107"] = { 
              categorie = "gmr_plat",
              label = "Pâte à beignet",
              image = "",
              props = "pizza_01",
              amount = 1,
              editable = false,
              ingredients = {
                        ["gmr_igd_oeuf"] = {amount = 1},
                        ["gmr_igd_sucre"] = {amount = 1},
                        ["gmr_igd_lait"] = {amount = 1},
                        ["gmr_igd_farine"] = {amount = 1},
                        ["gmr_igd_levure"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730057236503"] = { 
              categorie = "gmr_plat",
              label = "Pâte à muffin",
              image = "",
              props = "pizza_01",
              amount = 1,
              editable = false,
              ingredients = {
                        ["gmr_igd_oeuf"] = {amount = 1},
                        ["gmr_igd_sucre"] = {amount = 1},
                        ["gmr_igd_lait"] = {amount = 1},
                        ["gmr_igd_farine"] = {amount = 1},
                        ["gmr_igd_levure"] = {amount = 1},
                        ["gmr_igd_beurre"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730163868173"] = { 
              categorie = "gmr_plat",
              label = "Donuts",
              image = "https://png.pngtree.com/png-vector/20200531/ourlarge/pngtree-donut-illustration-in-icon-drawn-style-png-image_2216375.jpg",
              props = "burger_01",
              amount = 1,
              editable = true,
              ingredients = {
                        ["gmr_dsh_new_recipe_1730059630107"] = {amount = 1},
              },
    },
    ["gmr_dsh_new_recipe_1730161117917"] = { 
              categorie = "gmr_plat",
              label = "Pâte à Croissant",
              image = "",
              props = "pizza_01",
              amount = 1,
              editable = true,
              ingredients = {
                        ["gmr_igd_oeuf"] = {amount = 1},
                        ["gmr_igd_farine"] = {amount = 1},
                        ["gmr_igd_sucre"] = {amount = 1},
                        ["gmr_igd_lait"] = {amount = 1},
                        ["gmr_igd_eau"] = {amount = 1},
                        ["gmr_igd_levure"] = {amount = 1},
                        ["gmr_igd_beurre"] = {amount = 1},
              },
    },
}

Recipes.Compo = {
}

return Recipes
end
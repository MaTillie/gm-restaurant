// Liste pour stocker les articles
let itemsList = [];
let currentDiscount = 0.00;
let IndexCaisse = 0;
let Theme = "styles.css"
let Config = {}
let MenuCategorie = {}
let MenuRecipe = {}
let Key = ""

// Fonction pour ajouter ou mettre à jour un article
function updateItem(name, label, price, quantity) {
    // Rechercher si l'article existe déjà dans la liste
    const itemIndex = itemsList.findIndex(item => item.name === name);
    
    if (itemIndex === -1) {
        // Si l'article n'est pas dans la liste et la quantité est positive, on l'ajoute
        if (quantity > 0) {
            itemsList.push({ name, label, price, quantity });
        }
    } else {
        // Si l'article est déjà dans la liste
        if (quantity > 0) {
            // Mettre à jour la quantité
            itemsList[itemIndex].quantity = quantity;
        } else {
            // Si la quantité est 0, on retire l'article de la liste
            itemsList.splice(itemIndex, 1);
        }
    }

    console.log(`Quantité : ${itemsList.length}` )
    for (let i = 0; i < itemsList.length; i++) {
        const item = itemsList[i];
        console.log(`Name: ${item.name}, Label: ${item.label}, Price: ${item.price}, Quantity: ${item.quantity}`);
    }
    updateTotalPrice();
}

function updateTotalPrice() {
    let total = 0;

    itemsList.forEach(item => {
        total += item.price * item.quantity;
    });

    let discountedPrice = total - currentDiscount;
    // Mettre à jour l'élément HTML avec le total
    document.getElementById("initialPrice").textContent = total.toFixed(2);
    document.getElementById("discount").textContent = currentDiscount.toFixed(2);
    document.getElementById("totalPrice").textContent = discountedPrice.toFixed(2);    
}

document.getElementById("addButton").addEventListener("click", function(event) {
    if (event.ctrlKey) {
        currentDiscount += 5;  // Ajoute 5 si "Ctrl" est enfoncé
    } else {
        currentDiscount += 1;  // Sinon, ajoute 1
    }
    updateTotalPrice();
});

document.getElementById("subtractButton").addEventListener("click", function(event) {
    if (event.ctrlKey) {
        currentDiscount -= 5;  // Ajoute 5 si "Ctrl" est enfoncé
    } else {
        currentDiscount -= 1;  // Sinon, ajoute 1
    }
        updateTotalPrice();
});

function generateMenuItems(menuConfig) {
    // Vider les items actuels avant d'ajouter les nouveaux
    document.querySelector('.items-container').innerHTML = '';
    
    let themeLink = document.getElementById("theme-link");
    themeLink.setAttribute("href", Theme);
    
    const container = document.querySelector('.items-container'); // Conteneur avec scroll

    for (const categoryKey in menuConfig) {
        const category = menuConfig[categoryKey];

        // Créer un conteneur pour la catégorie
        const categoryContainer = document.createElement('div');
        categoryContainer.classList.add('category-container');

        const categoryDiv = document.createElement('div');
        categoryDiv.classList.add('category');

        // Ajouter le nom de la catégorie
        const categoryLabel = document.createElement('h2');
        categoryLabel.textContent = category.label;
        categoryDiv.appendChild(categoryLabel);

        // Créer le grid-container pour les items de cette catégorie
        const gridContainer = document.createElement('div');
        gridContainer.classList.add('grid-container');

        console.log("Catégorie :",category.label)
        // Ajouter les items de la catégorie
        category.items.forEach(item => {
            const itemDiv = document.createElement('div');
            itemDiv.classList.add('item');

            const img = document.createElement('img');
            img.src = item.image;
            img.alt = item.Label;

            itemDiv.appendChild(img);

            const itemInfoDiv = document.createElement('div');
            itemInfoDiv.classList.add('item-info');

            const itemName = document.createElement('p');
            itemName.textContent = item.Label.charAt(0).toUpperCase() + item.Label.slice(1);

            itemInfoDiv.appendChild(itemName);

            const priceTag = document.createElement('div');
            priceTag.classList.add('price-tag');
            priceTag.textContent = `$${item.price.toFixed(2)}`;

            itemInfoDiv.appendChild(priceTag);

            itemDiv.appendChild(itemInfoDiv);

            gridContainer.appendChild(itemDiv);
        });

        // Ajouter le grid-container des items à la catégorie
        categoryDiv.appendChild(gridContainer);

        // Ajouter la catégorie au conteneur principal
        categoryContainer.appendChild(categoryDiv);

        // Ajouter le conteneur de catégorie complet au container global
        container.appendChild(categoryContainer);
    }

    document.querySelector('.menu-container').style.display = 'flex';
    document.querySelector('.footer').style.display = 'none';
    document.querySelector('.mng_recipe').style.display = 'none';
}

function generateOrderItems(menuConfig) {
    // Vider les items actuels avant d'ajouter les nouveaux
    document.querySelector('.items-container').innerHTML = '';
    
    let themeLink = document.getElementById("theme-link");
    themeLink.setAttribute("href", Theme);
    
    const container = document.querySelector('.items-container'); // Conteneur avec scroll

    for (const categoryKey in menuConfig) {
        const category = menuConfig[categoryKey];

        // Créer un conteneur pour la catégorie
        const categoryContainer = document.createElement('div');
        categoryContainer.classList.add('category-container');

        const categoryDiv = document.createElement('div');
        categoryDiv.classList.add('category');

        // Ajouter le nom de la catégorie
        const categoryLabel = document.createElement('h2');
        categoryLabel.textContent = category.label;        
        categoryDiv.appendChild(categoryLabel);

        // Créer le grid-container pour les items de cette catégorie
        const gridContainer = document.createElement('div');
        gridContainer.classList.add('grid-container');

        console.log("Catégorie :",category.label)
        // Ajouter les items de la catégorie
        category.items.forEach(item => {
            const itemDiv = document.createElement('div');
            itemDiv.classList.add('item');

            const img = document.createElement('img');
            img.src = item.image;
            img.alt = item.Label;

            itemDiv.appendChild(img);

            const itemInfoDiv = document.createElement('div');
            itemInfoDiv.classList.add('item-info');

            const itemName = document.createElement('p');
            itemName.textContent = item.Label.charAt(0).toUpperCase() + item.Label.slice(1);

            itemInfoDiv.appendChild(itemName);

            const priceTag = document.createElement('div');
            priceTag.classList.add('price-tag');
            priceTag.textContent = `$${item.price.toFixed(2)}`;

            itemInfoDiv.appendChild(priceTag);

            const quantityControlDiv = document.createElement('div');
            quantityControlDiv.classList.add('quantity-control');

            // Ajouter quantityControlDiv à l'item
            itemInfoDiv.appendChild(quantityControlDiv);

            const minusBtn = document.createElement('button');
            minusBtn.classList.add('quantity-btn', 'minus-btn');
            minusBtn.textContent = '-';
            
            minusBtn.setAttribute('data-key', item.name);
            minusBtn.setAttribute('data-price', item.price);
            minusBtn.setAttribute('data-label', item.Label);

            const quantitySpan = document.createElement('span');
            quantitySpan.classList.add('quantity');
            quantitySpan.textContent = '0'; // Initialiser la quantité à 0

            const plusBtn = document.createElement('button');
            plusBtn.classList.add('quantity-btn', 'plus-btn');
            plusBtn.textContent = '+';
            
            plusBtn.setAttribute('data-key', item.name);
            plusBtn.setAttribute('data-price', item.price);
            plusBtn.setAttribute('data-label', item.Label);

            quantityControlDiv.appendChild(minusBtn);
            quantityControlDiv.appendChild(quantitySpan);
            quantityControlDiv.appendChild(plusBtn);

            itemDiv.appendChild(itemInfoDiv);

            gridContainer.appendChild(itemDiv);
            plusBtn.addEventListener('click', (event) => {
                const name = event.target.getAttribute('data-key');
                const price = event.target.getAttribute('data-price');
                const label = event.target.getAttribute('data-label');
                console.log(`Plus button clicked for item: ${name}, Price: ${price}, Label: ${label}`);
                
                let quantity = parseInt(quantitySpan.textContent);
                if (event.ctrlKey) {
                    quantity += 5;
                }else{
                    quantity += 1;
                }
                quantitySpan.textContent = quantity;

                updateItem(name, label, price, quantity)
            });

            minusBtn.addEventListener('click', (event) => {
                const name = event.target.getAttribute('data-key');
                const price = event.target.getAttribute('data-price');
                const label = event.target.getAttribute('data-label');
                console.log(`Minus button clicked for item: ${name}, Price: ${price}, Label: ${label}`);
                
                let quantity = parseInt(quantitySpan.textContent);
                if (event.ctrlKey) {
                    quantity -= 5;
                }else{
                    quantity -= 1;
                }

                if (quantity < 0) {
                    quantity = 0;
                }

                quantitySpan.textContent = quantity;

                updateItem(name, label, price, quantity)
            });
        });

        // Ajouter le grid-container des items à la catégorie
        categoryDiv.appendChild(gridContainer);

        // Ajouter la catégorie au conteneur principal
        categoryContainer.appendChild(categoryDiv);

        // Ajouter le conteneur de catégorie complet au container global
        container.appendChild(categoryContainer);
    }

    document.querySelector('.menu-container').style.display = 'flex';
    document.querySelector('.footer').style.display = 'flex';
}

function populateProductDropDown() {
    // Injecter les ingrédients dans la liste déroulante
   // MenuCategorie = eventData.data.categorie
     //       MenuRecipe = eventData.data.recipe

    let ingredientSelect = document.getElementById("product-select");

    // Injecter les ingrédients triés dans la liste déroulante

    Object.keys(MenuRecipe).forEach(category => {
        let option = document.createElement('option');
        option.value = category; 
        option.textContent = MenuRecipe[category].label; 
        ingredientSelect.appendChild(option);})
}

function addProductToMenu(){
    const productKey = document.getElementById('product-select').value;
    // WIP
    if (productKey) {
        const recipe = MenuRecipe[productKey];
        if (!recipe[productKey]) {
            // Si l'ingrédient n'existe pas déjà dans la recette, on l'ajoute
            recipe[productKey] = { amount: 1, base: true };
            loadRecipeDetails(currentRecipeKey); // Recharger la vue des détails de la recette
        } else {
            alert('Cet ingrédient est déjà présent dans la recette.');
        }
    } else {
        alert('Veuillez sélectionner un ingrédient.');
    }
}

function manage_price(menuItems) {
    console.log("manage_price count",menuItems.length)
    const tableBody = document.getElementById('menu-items');
    tableBody.innerHTML = ''; // Clear previous data

   
    for (let i = 0; i < menuItems.length; i++) {
        const item = menuItems[i];
        const row = document.createElement('tr');
        console.log('price ',item.price);
        console.log('label ',item.label);
        
        const itemNameCell = document.createElement('td');
        itemNameCell.textContent = item.label.charAt(0).toUpperCase() + item.label.slice(1);
        itemNameCell.id = item.name;
        row.appendChild(itemNameCell);

        const priceCell = document.createElement('td');
        const priceInput = document.createElement('input');
        priceInput.type = 'number';
        priceInput.value = item.price;
        priceInput.id = `price-${item}`;
        priceCell.appendChild(priceInput);
        row.appendChild(priceCell);

        tableBody.appendChild(row);
    }

    document.getElementById('mng_prix').style.display = 'flex';
    document.querySelector('.menu-container').style.display = 'none';
    document.querySelector('.footer').style.display = 'none';
    document.querySelector('.mng_recipe').style.display = 'none';
    
}

function manage_recipe(menuItems){
    // Vider les items actuels avant d'ajouter les nouveaux
    document.querySelector('.items-container').innerHTML = '';

    let themeLink = document.getElementById("theme-link");
    themeLink.setAttribute("href", Theme);

    for (let i = 0; i < menuItems.length; i++) {
        const item = menuItems[i];
        const row = document.createElement('tr');
        console.log('price ',item.price);
        console.log('label ',item.label);
        
        const itemNameCell = document.createElement('td');
        itemNameCell.textContent = item.label.charAt(0).toUpperCase() + item.label.slice(1);
        itemNameCell.id = item.name;
        row.appendChild(itemNameCell);

        const priceCell = document.createElement('td');
        const priceInput = document.createElement('input');
        priceInput.type = 'number';
        priceInput.value = item.price;
        priceInput.id = `price-${item}`;
        priceCell.appendChild(priceInput);
        row.appendChild(priceCell);

        tableBody.appendChild(row);
    }
    


}

// Retour au client lua
function callLuaFunction(data) {
    fetch(`https://${GetParentResourceName()}/nuiCallback`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    }).then(resp => resp.json()).then(resp => {
        console.log('Réponse Lua:', resp);
    }).catch(error => {
        console.error('Erreur lors de l\'appel Lua:', error);
    });
}

function savePrices() {
    const tableBody = document.getElementById('menu-items').children;
    const updatedMenu = {};

    for (let row of tableBody) {
        const itemName = row.children[0].id;
        const newPrice = parseFloat(row.children[1].children[0].value);

        updatedMenu[itemName] = newPrice;
    }
    callLuaFunction({ action: 'savePrices', param: {menu :updatedMenu }});
    closeMenu()
}

function closeMenu() {
    document.querySelector('.menu-container').style.display = 'none';
    document.getElementById('ticket').style.display = 'none';
    document.getElementById('mng_prix').style.display = 'none';
    document.getElementById('mng_recipe').style.display = 'none';    
    document.querySelector('.container').style.display = 'none';    
    callLuaFunction({ action: 'closeMenu', param: 'someValue' });
    itemsList = [];
    currentDiscount = 0.00;
}

function order() {
    document.querySelector('.menu-container').style.display = 'none';
    callLuaFunction({ action: 'order', param: {items :itemsList, indexCaisse:IndexCaisse, reduc:currentDiscount,cfg:Config,key:Key} });
    itemsList = [];
    currentDiscount = 0.00;
    updateTotalPrice()
    closeMenu()
}


let ingredientList = [];
let currentRecipe = {};
let ingredientCategories = {};
let recipes = {};
let recipesCategories = {};

$(document).ready(function () {
    window.addEventListener("message", (event) => {
      const eventData = event.data;
      Theme =  eventData.data.theme;
      let themeLink = document.getElementById("theme-link");
      themeLink.setAttribute("href", Theme);

      console.log("Theme :",eventData.data.theme )
      Config = eventData.data.cfg;
      switch (eventData.action) {
        case "openMenu":
          if (eventData.toggle) {
            generateMenuItems(eventData.data.items);
          } else {
            closeMenu();
          }
          break;
        case "openOrder":            
              if (eventData.toggle) {
                generateOrderItems(eventData.data.items);
                Key = eventData.data.key;
                IndexCaisse = eventData.data.indexCaisse;               
              } else {
                closeMenu();
              }
              break;
        case "managePrice":
            console.log("managePrice",eventData.data)
            const menuItems = eventData.data.menu;
            console.log("managePrice1",menuItems)

            MenuCategorie = eventData.data.categorie
            MenuRecipe = eventData.data.recipe
            populateProductDropDown();
            manage_price(menuItems)
              break;
        case "manageRecipe":      
        console.log("managePRecipe",eventData.data)
            recipes = eventData.data.recipe
            ingredientList = eventData.data.ingredient
            ingredientCategories = eventData.data.categoryIngredient
            recipesCategories = eventData.data.categoryDish 
            loadRecipeList();
            populateCategoryDropdown();
            populateDishCategoryDropdown();
              break;
        case "orderIngredient":  
            ingredientList = eventData.data.ingredient
            console.log("orderIngredient",ingredientList)
            document.querySelector('.menu-container').style.display = 'none';
            document.getElementById('ticket').style.display = 'none';
            document.getElementById('mng_prix').style.display = 'none';
            document.getElementById('mng_recipe').style.display = 'none';    
            document.querySelector('.container').style.display = 'block';    
            populateIngredientOrderDropdown();
            
        case "openTicket":
        console.log("openTicket :" )
       

        // Vider la liste des commandes
        const orderList = document.getElementById('orderList');
        orderList.innerHTML = '';

        // Ajouter les items à la liste
        eventData.data.items.forEach(item => {
            const listItem = document.createElement('li');
            listItem.textContent = `${item.name}  ${item.amount}`;  
            listItem.setAttribute('id', item.cl);    
                    
            orderList.appendChild(listItem);
        });

        // Afficher le ticket
        document.getElementById('ticket').style.display = 'block';
        break;
        default:
          break;
      }
    });
  });



  // Liste des recettes récupérées depuis Lua


let currentRecipeKey = null;

// Fonction pour afficher la liste des recettes
function loadRecipeList() {
    const recipeListDiv = document.getElementById('recipe-list');
    recipeListDiv.innerHTML = ''; // Vider la liste avant de la recharger

    const addBtn = document.createElement('button');
    addBtn.className = 'btn-add';
    addBtn.textContent = 'Ajouter une nouvelle recette';
    addBtn.onclick = addNewRecipe;
    recipeListDiv.appendChild(addBtn);

    const title = document.createElement('h2');
    title.textContent = 'Liste des Recettes';
    recipeListDiv.appendChild(title);
    console.log(recipes)
    for (let key in recipes) {
        console.log("loadRecipe",key)
        let recipe = recipes[key];

        let div = document.createElement('div');
        div.className = 'recipe-item';
        div.onclick = () => loadRecipeDetails(key);
        let label = document.createElement('span');
        label.textContent = recipe.label;
        label.onclick = () => loadRecipeDetails(key);

        let trashBtn = document.createElement('button');
        trashBtn.className = 'trash-button';
        trashBtn.textContent = '🗑️';
        trashBtn.onclick = () => deleteRecipe(key);

        div.appendChild(label);
        div.appendChild(trashBtn);

        recipeListDiv.appendChild(div);
    }   
    document.getElementById('mng_prix').style.display = 'none';
    document.querySelector('.menu-container').style.display = 'none';
    document.querySelector('.footer').style.display = 'none';
    document.getElementById('mng_recipe').style.display = 'block';
    document.getElementById('ticket').style.display = 'none';
}

// Fonction pour afficher les détails d'une recette
function loadRecipeDetails(recipeKey) {
    currentRecipeKey = recipeKey;
    const recipe = recipes[recipeKey];
    
    document.getElementById('category-select').value = recipe.categorie;
    document.getElementById('recipe-label').value = recipe.label;
    document.getElementById('recipe-label').key = recipeKey;
    document.getElementById('recipe-image').src = recipe.image;
    document.getElementById('image-url').value = recipe.image;

    const ingredientsList = document.getElementById('ingredients-list');
    ingredientsList.innerHTML = ''; // Vider la liste précédente
    for (let ingredientKey in recipe.ingredients) {
        let ingredient = recipe.ingredients[ingredientKey];
        console.log("loadRecipeDetails",ingredientKey);
        let li = document.createElement('li');  
        li.innerHTML = `
            <span class="ingredient-label">${ingredientList[ingredientKey].label}</span> 
            <button class="btn btn-small" onclick="changeAmount('${ingredientKey}', -1)">-</button>
            <span class="ingredient-amount">${ingredient.amount}</span>
            <button class="btn btn-small" onclick="changeAmount('${ingredientKey}', 1)">+</button>
        `;

        
        ingredientsList.appendChild(li);
    }
}

function changeAmount(ingredientKey, change) {
    const recipe = recipes[currentRecipeKey];
    const ingredient = recipe.ingredients[ingredientKey];

    // Modifier la quantité de l'ingrédient
    ingredient.amount += change;

    // Ne pas autoriser des quantités négatives
    if (ingredient.amount < 0) {
        ingredient.amount = 0;
    }

    // Recharger les détails de la recette pour mettre à jour l'affichage
    loadRecipeDetails(currentRecipeKey);
}

// Fonction pour ajouter une nouvelle recette
function addNewRecipe() {
    const newRecipeKey = `gmr_dsh_new_recipe_${Date.now()}`;
    recipes[newRecipeKey] = {
        categorie: "gmr_plat",
        label: "Nouvelle Recette",
        image: "",
        ingredients: {}
    };
    loadRecipeList();
    loadRecipeDetails(newRecipeKey);
}

// Fonction pour supprimer une recette
function deleteRecipe(recipeKey) {
    if (confirm('Êtes-vous sûr de vouloir supprimer cette recette ?')) {
        delete recipes[recipeKey]; // Supprimer la recette de la liste
        loadRecipeList(); // Recharger la liste des recettes après la suppression
    }
}

// Fonction pour mettre à jour l'image de la recette
function updateRecipeImage() {
    const newImageUrl = document.getElementById('image-url').value;

    if (newImageUrl) {
        document.getElementById('recipe-image').src = newImageUrl;
        const recipe = recipes[currentRecipeKey];
        recipe.image = newImageUrl;
    } else {
        alert("Veuillez entrer une URL valide pour l'image.");
    }
}

// Fonction pour enregistrer les modifications apportées à la recette
function saveRecipe() {
    const recipe = recipes[currentRecipeKey];
    recipe.label = document.getElementById('recipe-label').value;
    const category = document.getElementById('category-select').value;
    recipe.categorie = category;
    callLuaFunction({ action: 'saveRecipe', param: {recipes :recipes }});
}

// Fonction pour remplir la dropdown des catégories
function populateCategoryDropdown() {
    const categoryDropdown = document.getElementById('ingredient-category');
    categoryDropdown.innerHTML = '<option value="">Sélectionner une catégorie</option>';
    
    // Extraire les catégories et les trier par ordre alphabétique
    const sortedCategories = Object.keys(ingredientCategories).sort((a, b) => {
        return ingredientCategories[a].localeCompare(ingredientCategories[b]);
    });

    // Remplir la dropdown avec les catégories triées
    sortedCategories.forEach(category => {
        let option = document.createElement('option');
        option.value = ingredientCategories[category];
        option.textContent = ingredientCategories[category];
        categoryDropdown.appendChild(option);
    });
}

function populateDishCategoryDropdown() {
    const categoryDropdown = document.getElementById('category-select');
    categoryDropdown.innerHTML = '<option value="">Sélectionner un type</option>';
    
    // Itérer sur les clés de l'objet recipesCategories
    Object.keys(recipesCategories).forEach(category => {
        let option = document.createElement('option');
        option.value = category; // La valeur est la clé (ex: "gmr_plat")
        option.textContent = recipesCategories[category].label; // Le texte est le label (ex: "Plat")
        categoryDropdown.appendChild(option);
    });
}


function changeDishCategory(ingredientKey, change) {
    const recipe = recipes[currentRecipeKey];
    const ingredient = recipe.ingredients[ingredientKey];

    // Modifier la quantité de l'ingrédient
    ingredient.amount += change;

    // Ne pas autoriser des quantités négatives
    if (ingredient.amount < 0) {
        ingredient.amount = 0;
    }

    // Recharger les détails de la recette pour mettre à jour l'affichage
    loadRecipeDetails(currentRecipeKey);
}


// Fonction pour mettre à jour la dropdown des ingrédients en fonction de la catégorie choisie
function updateIngredientDropdown() {
    const category = document.getElementById('ingredient-category').value;
    const ingredientDropdown = document.getElementById('ingredient-select');
    ingredientDropdown.innerHTML = '<option value="">Sélectionner un ingrédient</option>';
    console.log("updateIngredientDropdown ", category);

    // Récupérer tous les ingrédients appartenant à la catégorie sélectionnée
    const filteredIngredients = [];
    for (const key in ingredientList) {
        if (ingredientList[key].cat === category) {
            filteredIngredients.push({ key: key, label: ingredientList[key].label });
        }
    }

    // Trier les ingrédients par label
    filteredIngredients.sort((a, b) => a.label.localeCompare(b.label));

    // Ajouter les ingrédients triés à la dropdown
    filteredIngredients.forEach(ingredient => {
        const option = document.createElement('option');
        option.value = ingredient.key; // la valeur de l'option est la clé de l'ingrédient
        option.textContent = ingredient.label; // le texte affiché est le label de l'ingrédient
        ingredientDropdown.appendChild(option);
    });
}


// Fonction pour ajouter un ingrédient à la recette
function addIngredientToRecipe() {
    const ingredientKey = document.getElementById('ingredient-select').value;

    if (ingredientKey) {
        const recipe = recipes[currentRecipeKey];
        if (!recipe.ingredients[ingredientKey]) {
            // Si l'ingrédient n'existe pas déjà dans la recette, on l'ajoute
            recipe.ingredients[ingredientKey] = { amount: 1, base: true };
            loadRecipeDetails(currentRecipeKey); // Recharger la vue des détails de la recette
        } else {
            alert('Cet ingrédient est déjà présent dans la recette.');
        }
    } else {
        alert('Veuillez sélectionner un ingrédient.');
    }
}


let orderIgd = {};
let totalPrice = 0;

function populateIngredientOrderDropdown() {
    
    console.log("populateIngredientOrderDropdown",JSON.stringify(ingredientList))
    // Injecter les ingrédients dans la liste déroulante
    let ingredientSelect = document.getElementById("ingredientOrder");

    let ingredientKeys = Object.keys(ingredientList).sort((a, b) => {
        let labelA = ingredientList[a].label.toLowerCase();
        let labelB = ingredientList[b].label.toLowerCase();
        return labelA.localeCompare(labelB);
    });
    
    // Injecter les ingrédients triés dans la liste déroulante

    ingredientKeys.forEach(key => {
        let option = document.createElement("option");
        option.value = key;
        option.textContent = ingredientList[key].label;
        ingredientSelect.appendChild(option);
    });
        
  /*  for (let key in ingredientList) {
        console.log(key);
        let option = document.createElement("option");
        option.value = key;
        option.textContent = ingredientList[key].label;
        ingredientSelect.appendChild(option);
    }*/
}

// Ajouter un ingrédient à la commande
document.getElementById("add-ingredient").addEventListener("click", function() {
    let ingredientSelect = document.getElementById("ingredientOrder");
    let selectedIngredient = ingredientSelect.value;
    if (!orderIgd[selectedIngredient]) {
        orderIgd[selectedIngredient] = {quantity: 1, price: ingredientList[selectedIngredient].price};
    } else {
        orderIgd[selectedIngredient].quantity += 1;
    }
    updateOrderTable();
});

// Mettre à jour le tableau des commandes
function updateOrderTable() {
    let orderTableBody = document.querySelector("#order-table tbody");
    orderTableBody.innerHTML = "";

    totalPrice = 0;

    for (let key in orderIgd) {
        let row = document.createElement("tr");

        // Nom de l'ingrédient
        let nameCell = document.createElement("td");
        nameCell.textContent = ingredientList[key].label;
        row.appendChild(nameCell);

        // Quantité avec boutons + et -
        let quantityCell = document.createElement("td");
        let minusBtn = document.createElement("button");
        minusBtn.textContent = "-";
        minusBtn.addEventListener("click", function() {
            if (orderIgd[key].quantity > 1) {
                orderIgd[key].quantity -= 1;
            } else {
                delete orderIgd[key];
            }
            updateOrderTable();
        });
        let plusBtn = document.createElement("button");
        plusBtn.textContent = "+";
        plusBtn.addEventListener("click", function() {
            orderIgd[key].quantity += 1;
            updateOrderTable();
        });
        quantityCell.appendChild(minusBtn);
        quantityCell.appendChild(document.createTextNode(` ${orderIgd[key].quantity} `));
        quantityCell.appendChild(plusBtn);
        row.appendChild(quantityCell);

        // Coût
        let costCell = document.createElement("td");
        let itemCost = orderIgd[key].quantity * ingredientList[key].price;
        costCell.textContent = `$${itemCost}`;
        row.appendChild(costCell);

        let infoCell = document.createElement("td");
        infoCell.textContent = `${ingredientList[key].amount}`;
        row.appendChild(infoCell);

        totalPrice += itemCost;

        orderTableBody.appendChild(row);
    }

    document.getElementById("total-price").textContent = `$${totalPrice}`;
}

// Valider la commande
document.getElementById("validate-order").addEventListener("click", function() {
    callLuaFunction({ action: 'saveIngredientOrder', param: {order :orderIgd }});
    closeMenu()
});


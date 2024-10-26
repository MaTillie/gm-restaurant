// Liste pour stocker les articles
let itemsList = [];
let currentDiscount = 0.00;
let IndexCaisse = 0;
let Theme = "styles.css"
let Config = {}
let MenuCategorie = {}
let MenuRecipe = {}
let MenuItems = {}
let Key = ""

function showSnackbar(message) {
    // Get the snackbar DIV
    var snackbar = document.getElementById("snackbar");
    snackbar.textContent = message;
    // Add the "show" class to make it visible
    snackbar.className = "show";

    // After 5 seconds, remove the "show" class to hide the snackbar
    setTimeout(function() {
        snackbar.className = snackbar.className.replace("show", "");
    }, 5000); // Duration set to 5 seconds

    
}

function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}




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

// Gestion prix/produit menu
function populateProductDropDown() {
    // Injecter les ingrédients dans la liste déroulante
   // MenuCategorie = eventData.data.categorie
     //       MenuRecipe = eventData.data.recipe

    let ingredientSelect = document.getElementById("product-select");
    ingredientSelect.innerHTML = '';
    let sortedCategories = Object.keys(MenuRecipe).sort((a, b) => {
        let labelA = MenuRecipe[a].label.toLowerCase();
        let labelB = MenuRecipe[b].label.toLowerCase();
        return labelA.localeCompare(labelB);
    });

    sortedCategories.forEach(category => {
        let option = document.createElement('option');
        option.value = category; 
        option.textContent = MenuRecipe[category].label; 
        ingredientSelect.appendChild(option);
    });
}

function populateMenuCategorieDropDown(){


        
        // Trier les catégories par ordre alphabétique du label
        MenuCategorie.sort((a, b) => {
            let labelA = a.label.toLowerCase();
            let labelB = b.label.toLowerCase();
            return labelA.localeCompare(labelB);
        });

        // Injecter les catégories triées dans la liste déroulante
        let selectElement = document.getElementById('product-category-select');
        selectElement.innerHTML = '';

        MenuCategorie.forEach(category => {
            let option = document.createElement('option');
            option.value = category.name;
            option.textContent = category.label;
            selectElement.appendChild(option);
        });

}

function addProductToMenu(){
    const productKey = document.getElementById('product-select').value;

    const catKey = document.getElementById('product-category-select').value;
    if(!catKey){
        catKey= "plat";
    }
    // WIP
    console.log("addProductToMenu",productKey)

    if (productKey) {
        if (!MenuItems.some(item => item.name === productKey)) {
            // Si l'ingrédient n'existe pas déjà dans la recette, on l'ajoute
            MenuItems.push({label : MenuRecipe[productKey].label, price : 20.00,name :productKey, categorie : catKey,  });

            manage_price(); // Recharger la vue des détails de la recette
        } else {
            showSnackbar('Ce produit est déjà présent dans le menu.');
        }
    } else {
        showSnackbar('Veuillez sélectionner un produit.');
    }
}

function deleteProductMenu(name){
    let indexToRemove = MenuItems.findIndex(item => item.name === name);

    // Vérifier si l'élément existe dans le tableau
    if (indexToRemove !== -1) {
        // Supprimer l'élément à cet index
        MenuItems.splice(indexToRemove, 1);
        manage_price(); // Recharger la vue des détails de la recette
    }
}

function changeProductPriceMenu(name){
    let indexToRemove = MenuItems.findIndex(item => item.name === name);
    
    // Vérifier si l'élément existe dans le tableau
    if (indexToRemove !== -1) {
        MenuItems[i].price = 
        // Supprimer l'élément à cet index
        MenuItems.splice(indexToRemove, 1);
        manage_price(); // Recharger la vue des détails de la recette
    }
}

function manage_price() {
    console.log("manage_price count", MenuItems.length);
    const tableBody = document.getElementById('menu-items');
    tableBody.innerHTML = ''; // Clear previous data

    for (let i = 0; i < MenuItems.length; i++) {
        const item = MenuItems[i];
        const row = document.createElement('tr');
        console.log('price ', item.price);
        console.log('label ', item.label);

        const itemNameCell = document.createElement('td');
        itemNameCell.textContent = item.label.charAt(0).toUpperCase() + item.label.slice(1);
        itemNameCell.id = item.name;
        row.appendChild(itemNameCell);

        const priceCell = document.createElement('td');
        const priceInput = document.createElement('input');
        priceInput.type = 'number';
        priceInput.value = item.price;
        priceInput.id = `price-${i}`;

        // Ajoutez un écouteur d'événements pour mettre à jour le prix dans MenuItems
        priceInput.addEventListener('input', (event) => {
            const newPrice = parseFloat(event.target.value);
            if (!isNaN(newPrice)) {
                MenuItems[i].price = newPrice; // Mettre à jour le prix dans MenuItems
                console.log(`Updated price for ${item.name}: ${newPrice}`);
            }
        });

        priceCell.appendChild(priceInput);

        let trashBtn = document.createElement('button');
        trashBtn.className = 'trash-button';
        trashBtn.textContent = '🗑️';
        trashBtn.onclick = () => deleteProductMenu(item.name);

        row.appendChild(priceCell);
        row.appendChild(trashBtn);

        tableBody.appendChild(row);
    }

    document.getElementById('mng_prix').style.display = 'flex';
    document.querySelector('.menu-container').style.display = 'none';
    document.querySelector('.footer').style.display = 'none';
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
        switch (resp.action) {
            case "defaut":
                console.log('Réponse Lua:', "ok");              
              break;
              case "getNearbyPlayers":
                selectPlayerOrder(resp.data)
                break
                default:
          break;

        }
        
    }).catch(error => {
        console.error('Erreur lors de l\'appel Lua:', error);
    });
}

function savePrices() {
    callLuaFunction({ action: 'savePrices', param: {menu :MenuItems }});
    closeMenu()
}

function closeMenu() {
    document.querySelector('.menu-container').style.display = 'none';
    document.getElementById('ticket').style.display = 'none';
    document.getElementById('mng_prix').style.display = 'none';
    document.getElementById('mng_recipe').style.display = 'none';    
    document.querySelector('.mng_ingredientOrder').style.display = 'none';    
    document.querySelector('.goCraft').style.display = 'none';    
    document.querySelector('.listFridgeIngredient').style.display = 'none';  
    document.querySelector('.listPlayerIngredient').style.display = 'none';
    
    callLuaFunction({ action: 'closeMenu', param: 'someValue' });
    itemsList = [];
    currentDiscount = 0.00;
}
/*
function order() {
    callLuaFunction({ action: 'getNearbyPlayers', param: {} });    
}   

function selectPlayerOrder(data){
    console.log("selectPlayerOrder")

    document.querySelector('.items-container').style.display = 'none';
    document.querySelector('.footer').style.display = 'none';
    document.querySelector('.playerList').style.display = 'flex';
    
    const dropdown = document.getElementById('player-select');
    data.forEach(player => {
        console.log("selectPlayerOrder1 ",player.id)
        let option = document.createElement('option');
        option.value = player.id;
        option.textContent = player.id;
        dropdown.appendChild(option);
    });

    document.querySelector('.items-container').style.display = 'block';
    document.querySelector('.footer').style.display = 'flex';
    document.querySelector('.playerList').style.display = 'none';
}*/
let proxiPlayers = {}
function order() {
    populatePlayerListDropdown()
}   

function populatePlayerListDropdown(){
    
    document.querySelector('.items-container').style.display = 'none';
    document.querySelector('.footer').style.display = 'none';
    document.querySelector('.playerList').style.display = 'flex';
    
    const dropdown = document.getElementById('player-select');
    dropdown.innerHTML = '<option value="">-- Sélectionnez un joueur --</option>';
console.log("populatePlayerListDropdown");

proxiPlayers.forEach(function(player) {
    const option = document.createElement('option');
    option.value = player.citizenid; // Utiliser citizenid comme valeur
    option.text = player.name; // Utiliser name pour l'affichage
    dropdown.appendChild(option);
});


}

function valideOrder(){
    const targetPlayer = document.getElementById('player-select').value;
    if(!targetPlayer){
        showSnackbar("Veuillez sélectionner le client.")
    }else{
        document.querySelector('.menu-container').style.display = 'none';
        callLuaFunction({ action: 'order', param: {items :itemsList, indexCaisse:IndexCaisse, reduc:currentDiscount,cfg:Config,key:Key,targetPlayer:targetPlayer} });
        itemsList = [];
        currentDiscount = 0.00;
        updateTotalPrice()
        document.querySelector('.items-container').style.display = 'block';
        document.querySelector('.footer').style.display = 'flex';
        document.querySelector('.playerList').style.display = 'none';
        closeMenu()
    }
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
                document.querySelector('.playerList').style.display = 'none';
                generateOrderItems(eventData.data.items);
                proxiPlayers = eventData.data.players
                Key = eventData.data.key;
                IndexCaisse = eventData.data.indexCaisse;           
              } else {
                closeMenu();
              }
             
              break;
        case "managePrice":
            console.log("managePrice",eventData.data)
            MenuItems = eventData.data.menu;
            console.log("managePrice1",MenuItems)             
            MenuCategorie = eventData.data.categorie
            MenuRecipe = eventData.data.recipe
            populateMenuCategorieDropDown();
            populateProductDropDown();
            manage_price();
            document.querySelector('.menu-container').style.display = 'none';
            document.getElementById('ticket').style.display = 'none';
            document.getElementById('mng_prix').style.display = 'block';
            document.getElementById('mng_recipe').style.display = 'none';   
            document.querySelector('.container').style.display = 'none';   
              break;
        case "manageRecipe":      
        console.log("managePRecipe",eventData.data)
            recipes = eventData.data.recipe
            ingredientList = eventData.data.ingredient
            ingredientCategories = eventData.data.categoryIngredient
            recipesCategories = eventData.data.categoryDish 
            RecipeEditor =  eventData.data.boss
            loadRecipeList();
            populateCategoryDropdown();
            populateDishCategoryDropdown();
            document.querySelector('.menu-container').style.display = 'none';
            document.getElementById('ticket').style.display = 'none';
            document.getElementById('mng_prix').style.display = 'none';
            document.getElementById('mng_recipe').style.display = 'block';   
            document.querySelector('.container').style.display = 'none';   
              break;
        case "orderIngredient":  
            ingredientList = eventData.data.ingredient
            console.log("orderIngredient",ingredientList)
            populateIngredientOrderDropdown();
            break;
        case "goCraft":
            goCraft_product_list = eventData.data.products;
            populateGoCraftProductDropdown();
            break;
        case "displayListFridgeIngredient":
            console.log("displayListFridgeIngredient")
            listFridgeIngredient = eventData.data.data
            loadListFridgeIngredient()
              break;
        case "displayListPlayerIngredient":
            listPlayerIngredient = eventData.data.data
            populateListPlayerIngredientDropdown()
            break;
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



  
/*
##############################################
manageRecipe - Début
##############################################
*/

let currentRecipeKey = null;
let RecipeEditor = false;

// Fonction pour afficher la liste des recettes
function loadRecipeList() {
    const recipeListDiv = document.getElementById('recipe-list');
    recipeListDiv.innerHTML = ''; // Vider la liste avant de la recharger
    currentRecipeKey = null
    const addBtn = document.createElement('button');
    addBtn.className = 'btn-add';
    addBtn.textContent = 'Ajouter une nouvelle recette';
    addBtn.onclick = addNewRecipe;
    if(RecipeEditor){
        recipeListDiv.appendChild(addBtn);
    }
    

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
        if(RecipeEditor){
            div.appendChild(trashBtn);
        }

        recipeListDiv.appendChild(div);
    }   

    if(!RecipeEditor){        
        document.getElementById('.recipe-details-btn').style.display = 'none';        
        document.querySelector('.btn-add').style.display = 'none';
        document.querySelector('.btn-small').style.display = 'none';        
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
    const recipe = recipes[currentRecipeKey];
    document.getElementById('recipe-details').style.display = "block";

    document.getElementById('category-select').value = recipe.categorie;
    document.getElementById('recipe-label').value = recipe.label;
    document.getElementById('recipe-label').key = currentRecipeKey;
    document.getElementById('recipe-image').src = recipe.image;
    document.getElementById('image-url').value = recipe.image;

    if(!RecipeEditor){        
        document.getElementById('.recipe-details-btn').style.display = 'none';          
    }
    if(recipe.image==""){
        document.getElementById('recipe-image').src = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/coal.png";
    }

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
    document.getElementById('recipe-image').src = "https://r2.fivemanage.com/UvidZxPIxWITZ0rY8lXWR/images/coal.png";
}

// Fonction pour supprimer une recette
function deleteRecipe(recipeKey) {

        delete recipes[recipeKey]; // Supprimer la recette de la liste
        loadRecipeList(); // Recharger la liste des recettes après la suppression
    
}

// Fonction pour mettre à jour l'image de la recette
function updateRecipeImage() {
    const newImageUrl = document.getElementById('image-url').value;

    if (newImageUrl) {
        document.getElementById('recipe-image').src = newImageUrl;
        const recipe = recipes[currentRecipeKey];
        recipe.image = newImageUrl;        
    } else {
        showSnackbar("Veuillez entrer une URL valide pour l'image.");
    }
}

// Fonction pour enregistrer les modifications apportées à la recette
function saveRecipe() {
    const recipe = recipes[currentRecipeKey];

    // Vérifie si l'objet ingredients est vide
    if(Object.keys(recipe.ingredients).length === 0){
        showSnackbar("Veuillez ajouter des ingrédients.");
    }else{
        recipe.label = document.getElementById('recipe-label').value;
        const category = document.getElementById('category-select').value;
        recipe.categorie = category;
        if (RecipeEditor){
            callLuaFunction({ action: 'saveRecipe', param: {recipes :recipes }});
        }else{
            showSnackbar("Vous n'avez pas le droit de modifier les recettes.");
        }    
        loadRecipeList();
    }   
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
            recipe.label = document.getElementById('recipe-label').value;
            loadRecipeDetails(currentRecipeKey); // Recharger la vue des détails de la recette
        } else {
            showSnackbar('Cet ingrédient est déjà présent dans la recette.');
        }
    } else {
        showSnackbar('Veuillez sélectionner un ingrédient.');
    }
}

/*
##############################################
manageRecipe - Fin
##############################################
*/


let orderIgd = {};
let totalPrice = 0;

function populateIngredientOrderDropdown() {
    
    console.log("populateIngredientOrderDropdown",JSON.stringify(ingredientList))
    // Injecter les ingrédients dans la liste déroulante
    let ingredientSelect = document.getElementById("ingredientOrder");
    ingredientSelect.innerHTML = "<option value=''>Sélectionner un ingrédient</option>";
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
    document.getElementById("mng_ingredientOrder").style.display = 'flex';
    
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

        let quantityCell = document.createElement("td");
quantityCell.classList.add("quantity-cell");

let minusBtn = document.createElement("button");
minusBtn.textContent = "-";
minusBtn.classList.add("minus-btn"); // Ajoute une classe pour le CSS
minusBtn.addEventListener("click", function(event) {
    let qte = 1;
    if (event.ctrlKey) {
        qte += 5;  // Ajoute 5 si "Ctrl" est enfoncé
    }

    if (orderIgd[key].quantity > qte) {
        orderIgd[key].quantity -= qte;
    } else {
        delete orderIgd[key];
    }
    updateOrderTable();
});

let plusBtn = document.createElement("button");
plusBtn.textContent = "+";
plusBtn.classList.add("plus-btn"); // Ajoute une classe pour le CSS
plusBtn.addEventListener("click", function(event) {
    let qte = 1;
    if (event.ctrlKey) {
        qte += 5;  // Ajoute 5 si "Ctrl" est enfoncé
    }
    orderIgd[key].quantity += qte;
    updateOrderTable();
});

let quantityText = document.createElement("span");
quantityText.classList.add("quantity-text"); // Classe pour la largeur fixe
quantityText.appendChild(document.createTextNode(`${orderIgd[key].quantity}`));

quantityCell.appendChild(minusBtn);
quantityCell.appendChild(quantityText);
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

/*
##############################################
goCraft - Début
##############################################
*/

let goCraft_product_list = {}
let goCraft_current_craft = {}

function populateGoCraftProductDropdown() {
    const productDropdown = document.getElementById('goCraft-select-product');
    productDropdown.innerHTML = '<option value="">Sélectionner un produit</option>';
    goCraft_current_craft = {}

    for (let key in goCraft_product_list) {
        let recipe = goCraft_product_list[key];

        let option = document.createElement('option');
        option.value = key; // La valeur est la clé (ex: "gmr_plat")
        option.textContent = recipe.label; // Le texte est le label (ex: "Plat")
        productDropdown.appendChild(option);
    }  
    document.querySelector('.goCraft').style.display = 'flex';
}

function goCraftChangeProduct(){
    const productDropdown = document.getElementById('goCraft-select-product');
    let selectedProduct = productDropdown.value;
    goCraft_current_craft = {};
    goCraft_current_craft.item = selectedProduct;
    goCraft_current_craft.amount = 1;
    document.getElementById("goCraft-quantity").textContent = goCraft_current_craft.amount
}

document.getElementById("goCraft-plus").addEventListener("click", function(event) {
    if (event.ctrlKey) {
        goCraft_current_craft.amount += 5; 
    } else {
        goCraft_current_craft.amount += 1; 
    }

    if (goCraft_current_craft.amount >10){
        goCraft_current_craft.amount = 10
    }

    document.getElementById("goCraft-quantity").textContent = goCraft_current_craft.amount
});

document.getElementById("goCraft-minus").addEventListener("click", function(event) {
    if (event.ctrlKey) {
        goCraft_current_craft.amount -= 5; 
    } else {
        goCraft_current_craft.amount -= 1; 
    }

    if (goCraft_current_craft.amount <1){
        goCraft_current_craft.amount = 1
    }
    document.getElementById("goCraft-quantity").textContent = goCraft_current_craft.amount
});




async function goCraftProduct(){
    if(goCraft_current_craft.item){
        let time = 1000;

        if(goCraft_current_craft.amount<1){ // sécurité
            goCraft_current_craft.amount = 1
        }

        if(goCraft_current_craft.amount<=10){
            for (let i = 1; i <= goCraft_current_craft.amount; i++) {
                time += 2500 - (250 * i)
            }
        }else{
            for (let i = 1; i <= 10; i++) {
                time += 2500 - (250 * i)
            }
            time += (goCraft_current_craft.amount - 10 )* 250;
        }

        document.getElementById('goCraft-validate').style.display = 'none';
        document.querySelector('.loading-container').style.display = 'block';
        document.getElementById("goCraft-close-button").style.display = 'none';
        

        setTimeout(() => {
            document.querySelector('.loading-container').style.display = 'none';
            document.getElementById('goCraft-validate').style.display = 'block';
            document.getElementById("goCraft-close-button").style.display = 'block';
        }, time);
    
        callLuaFunction({ action: 'goCraftProduct', param: {item :goCraft_current_craft.item,amount:goCraft_current_craft.amount }});
        await wait(time);
        closeMenu()
    }else{
        showSnackbar("Veuillez sélectionner un produit.")
    }    
}


/*
##############################################
goCraft - Fin
##############################################
*/

/*
##############################################
listFridgeIngredient - Début
##############################################
*/
let listFridgeIngredient = {}
function loadListFridgeIngredient(){
    console.log("loadListFridgeIngredient")
    document.querySelector('.listFridgeIngredient').style.display = 'flex';  
   
    let tableBody = document.getElementById('items-table-body');
    tableBody.innerHTML = ''; // Réinitialiser le tableau pour pas de doublon

    listFridgeIngredient.forEach(item => {
        let row = document.createElement('tr');

        let labelCell = document.createElement('td');
        labelCell.textContent = item.label;

        let countCell = document.createElement('td');
        countCell.textContent = item.count;

        row.appendChild(labelCell);
        row.appendChild(countCell);

        tableBody.appendChild(row);
    });
}

/*
##############################################
listFridgeIngredient - Fin
##############################################
*/

/*
##############################################
listPlayerIngredient - Début
##############################################
*/
let listPlayerIngredient = {}

function populateListPlayerIngredientDropdown() {
    const productDropdown = document.getElementById('listPlayerIngredient-select-product');
    productDropdown.innerHTML = '<option value="">Sélectionner un produit</option>';
    console.log(JSON.stringify(listPlayerIngredient))
    for (let key in listPlayerIngredient) {
        let recipe = listPlayerIngredient[key];

        let option = document.createElement('option');
        option.value = key; 
        option.textContent = recipe.label+" ("+recipe.amount +")"; 
        productDropdown.appendChild(option);
    }  
    document.querySelector('.listPlayerIngredient').style.display = 'flex';
}

function goListPlayerIngredient(){
    const productDropdown = document.getElementById('listPlayerIngredient-select-product');
    let selectedProduct = productDropdown.value;
    
    if(!selectedProduct){
        showSnackbar("Veuillez sélectionner un produit.")
    }else{
        callLuaFunction({ action: 'goListPlayerIngredient', param: {item :listPlayerIngredient[selectedProduct] }});
        closeMenu()
    }
    // fin
}
/*
##############################################
listPlayerIngredient - Fin
##############################################
*/

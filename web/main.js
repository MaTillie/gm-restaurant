// Liste pour stocker les articles
let itemsList = [];
let currentDiscount = 0.00;
let IndexCaisse = 0;
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
    document.querySelector('.grid-container').innerHTML = '';
    const container = document.querySelector('.grid-container'); // Conteneur où les items seront ajoutés    
    for (const key in menuConfig) {
        if (menuConfig[key].menu) { // On vérifie que c'est bien un item du menu
            const item = menuConfig[key];

            // Créer l'élément div.item
            const itemDiv = document.createElement('div');
            itemDiv.classList.add('item');

            // Créer l'élément img
            const img = document.createElement('img');
            img.src = `image/${key}.png`; // Suppose que l'image suit le nom de la clé
            img.alt = key;

            // Ajouter l'image au div item
            itemDiv.appendChild(img);

            // Créer l'élément div.item-info
            const itemInfoDiv = document.createElement('div');
            itemInfoDiv.classList.add('item-info');

            // Créer l'élément p pour le nom de l'item
            const itemName = document.createElement('p');
            itemName.textContent = key.charAt(0).toUpperCase() + item.Label.slice(1); // Nom de l'item

            // Ajouter le nom de l'item à item-info
            itemInfoDiv.appendChild(itemName);

            // Créer l'élément div.price-tag pour le prix
            const priceTag = document.createElement('div');
            priceTag.classList.add('price-tag');
            priceTag.textContent = `$${item.price.toFixed(2)}`; // Prix de l'item

            // Ajouter la price-tag à item-info
            itemInfoDiv.appendChild(priceTag);

            // Ajouter item-info à l'item
            itemDiv.appendChild(itemInfoDiv);

            // Ajouter l'item complet au container
            container.appendChild(itemDiv);
        }
        document.querySelector('.menu-container').style.display = 'flex';
        document.querySelector('.footer').style.display = 'none';
    }
}


function generateOrderItems(menuConfig) {
    document.querySelector('.grid-container').innerHTML = '';
    const container = document.querySelector('.grid-container'); // Conteneur où les items seront ajoutés    
    for (const key in menuConfig) {
        if (menuConfig[key].menu) { // On vérifie que c'est bien un item du menu
            const item = menuConfig[key];
                
            // Créer l'élément div.item
            const itemDiv = document.createElement('div');
            itemDiv.classList.add('item');

            // Créer l'élément img
            const img = document.createElement('img');
            img.src = `image/${key}.png`; // Suppose que l'image suit le nom de la clé
            img.alt = key;

            // Ajouter l'image au div item
            itemDiv.appendChild(img);

            // Créer l'élément div.item-info
            const itemInfoDiv = document.createElement('div');
            itemInfoDiv.classList.add('item-info');

            // Créer l'élément p pour le nom de l'item
            const itemName = document.createElement('p');
            itemName.textContent = item.Label.charAt(0).toUpperCase() + item.Label.slice(1); // Nom de l'item

            // Ajouter le nom de l'item à item-info
            itemInfoDiv.appendChild(itemName);

            // Créer l'élément div.price-tag pour le prix
            const priceTag = document.createElement('div');
            priceTag.classList.add('price-tag');
            priceTag.textContent = `$${item.price.toFixed(2)}`; // Prix de l'item

            // Ajouter la price-tag à item-info
            itemInfoDiv.appendChild(priceTag);

            const quantityControlDiv = document.createElement('div');
            quantityControlDiv.classList.add('quantity-control');

            // Ajouter quantityControlDiv à l'item
            itemInfoDiv.appendChild(quantityControlDiv);

            const minusBtn = document.createElement('button');
            minusBtn.classList.add('quantity-btn', 'minus-btn');
            minusBtn.textContent = '-';
            
            minusBtn.setAttribute('data-key', key);
            minusBtn.setAttribute('data-price', item.price);
            minusBtn.setAttribute('data-label', item.Label);

            const quantitySpan = document.createElement('span');
            quantitySpan.classList.add('quantity');
            quantitySpan.textContent = '0'; // Initialiser la quantité à 0

            const plusBtn = document.createElement('button');
            plusBtn.classList.add('quantity-btn', 'plus-btn');
            plusBtn.textContent = '+';
            
            plusBtn.setAttribute('data-key', key);
            plusBtn.setAttribute('data-price', item.price);
            plusBtn.setAttribute('data-label', item.Label);

            quantityControlDiv.appendChild(minusBtn);
            quantityControlDiv.appendChild(quantitySpan);
            quantityControlDiv.appendChild(plusBtn);
            
            // Ajouter item-info à l'item
            itemDiv.appendChild(itemInfoDiv);

            // Ajouter l'item complet au container
            container.appendChild(itemDiv);

        
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
           
        }
        document.querySelector('.menu-container').style.display = 'flex';
        document.querySelector('.footer').style.display = 'flex';
    }
}

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

function closeMenu() {
    document.querySelector('.menu-container').style.display = 'none';
    document.getElementById('ticket').style.display = 'none';
    callLuaFunction({ action: 'closeMenu', param: 'someValue' });
    itemsList = [];
    currentDiscount = 0.00;
}

function order() {
    document.querySelector('.menu-container').style.display = 'none';
    callLuaFunction({ action: 'order', param: {items :itemsList, indexCaisse:IndexCaisse, reduc:currentDiscount} });
    itemsList = [];
    currentDiscount = 0.00;
    updateTotalPrice()
    closeMenu()
}

$(document).ready(function () {
    window.addEventListener("message", (event) => {
      const eventData = event.data;
      switch (eventData.action) {
        case "openMenu":
          if (eventData.toggle) {
            generateMenuItems(eventData.data);
          } else {
            closeMenu();
          }
          break;
        case "openOrder":            
              if (eventData.toggle) {
                generateOrderItems(eventData.data.items);
                IndexCaisse = eventData.data.indexCaisse;
              } else {
                closeMenu();
              }
              break;
              case "openTicket":
                console.log("openTicket :" )
                // Vider la liste des commandes
                const orderList = document.getElementById('orderList');
                orderList.innerHTML = '';
        
                // Ajouter les items à la liste
                eventData.items.forEach(item => {
                    const listItem = document.createElement('li');
                    listItem.textContent = `${item.name}  ${item.amount}`;  
                    listItem.setAttribute('id', item.cl);    
                         
                    orderList.appendChild(listItem);
                });
        
                // Afficher le ticket
                document.getElementById('ticket').style.display = 'block';

        default:
          break;
      }
    });
  });
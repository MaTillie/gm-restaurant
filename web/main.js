
  

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
        document.querySelector('.menu-container').style.display = 'block';
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
    callLuaFunction({ action: 'closeMenu', param: 'someValue' });
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
        case "closeMenu":
            closeMenu();
          break;
        case "updateMeter":
          updateMeter(eventData.data);
          break;
        case "resetMeter":
          resetMeter();
          break;
        default:
          break;
      }
    });
  });
IngList = {}
IngList.Base = {    
    -- Liquide --
    ['gmr_igd_eau'] = {label = 'Eau', weight = 50, stack = true, close = true, cat = 'Liquide', amount = 50, price = 5},
    ["gmr_igd_jus_de_citron"] = {label = 'Jus de citron', weight = 10, stack = true, close = true, cat = 'Liquide', amount = 50, price = 5},

    -- Légumes --
    ['gmr_igd_tomate'] = {label = 'Tomate', weight = 50, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_oignon'] = {label = 'Oignon', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_echalotte'] = {label = 'Échalotte', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_pomme_de_terre'] = {label = 'Pomme de terre', weight = 60, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_carotte'] = {label = 'Carotte', weight = 45, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_salade'] = {label = 'Salade', weight = 30, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_aubergine'] = {label = 'Aubergine', weight = 50, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_poivron'] = {label = 'Poivron', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_courgette'] = {label = 'Courgette', weight = 35, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_brocoli'] = {label = 'Brocoli', weight = 50, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_chou_fleur'] = {label = 'Chou-fleur', weight = 55, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_ail'] = {label = 'Ail', weight = 10, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_radis'] = {label = 'Radis', weight = 15, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_epinard'] = {label = 'Épinard', weight = 20, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_champignon'] = {label = 'Champignon', weight = 25, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_asperge'] = {label = 'Asperge', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_chou'] = {label = 'Chou', weight = 60, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_navet'] = {label = 'Navet', weight = 45, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_poireau'] = {label = 'Poireau', weight = 35, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_celeri'] = {label = 'Céleri', weight = 30, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_haricot_vert'] = {label = 'Haricot vert', weight = 30, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_fenouil'] = {label = 'Fenouil', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_endive'] = {label = 'Endive', weight = 35, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_celeri_rave'] = {label = 'Céleri-rave', weight = 50, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_salsifis'] = {label = 'Salsifis', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_topinambour'] = {label = 'Topinambour', weight = 45, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_courge'] = {label = 'Courge', weight = 60, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_potiron'] = {label = 'Potiron', weight = 70, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_betterave_rouge'] = {label = 'Betterave rouge', weight = 60, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_olive_noire'] = {label = 'Olives noires', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_cornichon'] = {label = 'Cornichons', weight = 20, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_olive_verte'] = {label = 'Olives vertes', weight = 40, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_citrouille'] = {label = 'Citrouille', weight = 100, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_jalapeno'] = {label = 'Jalapeños', weight = 20, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    ['gmr_igd_avocat'] = {label = 'Avocat', weight = 35, stack = true, close = true, cat = 'Légume', amount = 10, price = 5},
    

    -- Fruits --
    ['gmr_igd_pomme'] = {label = 'Pomme', weight = 30, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_banane'] = {label = 'Banane', weight = 35, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_orange'] = {label = 'Orange', weight = 40, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_citron'] = {label = 'Citron', weight = 25, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_poire'] = {label = 'Poire', weight = 35, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_peche'] = {label = 'Pêche', weight = 35, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_cerise'] = {label = 'Cerise', weight = 20, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_abricot'] = {label = 'Abricot', weight = 25, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_ananas'] = {label = 'Ananas', weight = 60, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_pasteque'] = {label = 'Pastèque', weight = 80, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_melon'] = {label = 'Melon', weight = 60, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_raisins'] = {label = 'Raisins', weight = 30, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_prune'] = {label = 'Prune', weight = 30, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_kiwi'] = {label = 'Kiwi', weight = 30, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_mangue'] = {label = 'Mangue', weight = 40, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_fraise'] = {label = 'Fraise', weight = 20, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_framboise'] = {label = 'Framboise', weight = 15, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_groseille'] = {label = 'Groseille', weight = 15, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_raisin_sec'] = {label = 'Raisin sec', weight = 10, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_noix_de_coco'] = {label = 'Noix de coco', weight = 30, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_figue'] = {label = 'Figue', weight = 25, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_grenade'] = {label = 'Grenade', weight = 40, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_pamplemousse'] = {label = 'Pamplemousse', weight = 50, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_myrtille'] = {label = 'Myrtille', weight = 50, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},
    ['gmr_igd_litchi'] = {label = 'Litchi', weight = 50, stack = true, close = true, cat = 'Fruit', amount = 10, price = 5},

    -- Viandes --
    ['gmr_igd_jambon'] = {label = 'Jambon', weight = 45, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_poulet'] = {label = 'Poulet', weight = 60, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_porc'] = {label = 'Porc', weight = 70, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_boeuf'] = {label = 'Bœuf', weight = 70, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_saucisse'] = {label = 'Saucisse', weight = 50, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_merguez'] = {label = 'Merguez', weight = 45, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_lardon'] = {label = 'Lardon', weight = 45, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_bacon'] = {label = 'Bacon', weight = 40, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_saucisson'] = {label = 'Saucisson', weight = 45, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_canard'] = {label = 'Canard', weight = 65, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_lapin'] = {label = 'Lapin', weight = 60, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_agneau'] = {label = 'Agneau', weight = 70, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_veau'] = {label = 'Veau', weight = 65, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_cote_de_porc'] = {label = 'Côte de porc', weight = 55, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_cote_de_boeuf'] = {label = 'Côte de bœuf', weight = 75, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ['gmr_igd_foie_gras'] = {label = 'Foie gras', weight = 50, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},
    ["gmr_igd_os_veau"] = {label = 'Os de veau', weight = 60, stack = true, close = true, cat = 'Viande', amount = 2, price = 5},

    -- Poissons et fruits de mer --
    ['gmr_igd_saumon'] = {label = 'Saumon', weight = 60, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_thon'] = {label = 'Thon', weight = 55, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_sardine'] = {label = 'Sardine', weight = 25, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_crevette'] = {label = 'Crevette', weight = 25, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_crabe'] = {label = 'Crabe', weight = 30, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_homard'] = {label = 'Homard', weight = 45, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_moules'] = {label = 'Moules', weight = 35, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_huitres'] = {label = 'Huîtres', weight = 40, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_bar'] = {label = 'Bar', weight = 50, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_daurade'] = {label = 'Daurade', weight = 55, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_cabillaud'] = {label = 'Cabillaud', weight = 60, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_sole'] = {label = 'Sole', weight = 50, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_truite'] = {label = 'Truite', weight = 55, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_merlu'] = {label = 'Merlu', weight = 45, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_calmar'] = {label = 'Calmar', weight = 35, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_coquille_saint_jacques'] = {label = 'Coquille Saint-Jacques', weight = 50, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_ormeaux'] = {label = 'Ormeaux', weight = 30, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_langoustine'] = {label = 'Langoustine', weight = 40, stack = true, close = true, cat = 'Fruit de mer', amount = 2, price = 5},
    ['gmr_igd_anguille'] = {label = 'Anguille', weight = 60, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},
    ['gmr_igd_rouget'] = {label = 'Rouget', weight = 45, stack = true, close = true, cat = 'Poisson', amount = 2, price = 5},

    -- Produits laitiers et œufs --
    ['gmr_igd_lait'] = {label = 'Lait', weight = 55, stack = true, close = true, cat = 'Produit laitier', amount = 10, price = 5},
    ['gmr_igd_creme_fraiche'] = {label = 'Crème fraiche', weight = 55, stack = true, close = true, cat = 'Produit laitier', amount = 10, price = 5},
    ['gmr_igd_oeuf'] = {label = 'Œuf', weight = 20, stack = true, close = true, cat = 'Produit laitier', amount = 10, price = 5},
    ['gmr_igd_gruyere'] = {label = 'Gruyère', weight = 50, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_parmesan'] = {label = 'Parmesan', weight = 40, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_feta'] = {label = 'Feta', weight = 30, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_roquefort'] = {label = 'Roquefort', weight = 50, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_camembert'] = {label = 'Camembert', weight = 45, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_mozzarella'] = {label = 'Mozzarella', weight = 45, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_ricotta'] = {label = 'Ricotta', weight = 40, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_cheddar'] = {label = 'Cheddar', weight = 50, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_comte'] = {label = 'Comté', weight = 50, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_emmental'] = {label = 'Emmental', weight = 45, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_brie'] = {label = 'Brie', weight = 40, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_reblochon'] = {label = 'Reblochon', weight = 45, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_chavroux'] = {label = 'Chavroux', weight = 30, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_cantal'] = {label = 'Cantal', weight = 55, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_brebis'] = {label = 'Fromage de brebis', weight = 35, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_stilton'] = {label = 'Stilton', weight = 40, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_maroilles'] = {label = 'Maroilles', weight = 50, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_abondance'] = {label = 'Abondance', weight = 50, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_tomme'] = {label = 'Tomme', weight = 45, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},
    ['gmr_igd_gorgonzola'] = {label = 'Gorgonzola', weight = 40, stack = true, close = true, cat = 'Fromage', amount = 5, price = 5},

    -- Huiles et matières grasses --
    ['gmr_igd_huile_olive'] = {label = 'Huile d\'olive', weight = 60, stack = true, close = true, cat = 'Huile', amount = 50, price = 5},
    ['gmr_igd_beurre'] = {label = 'Beurre', weight = 25, stack = true, close = true, cat = 'Matière grasse', amount = 10, price = 5},
    ['gmr_igd_beurre_salé'] = {label = 'Beurre salé', weight = 25, stack = true, close = true, cat = 'Matière grasse', amount = 10, price = 5},
    ['gmr_igd_huile_tournesol'] = {label = 'Huile de tournesol', weight = 60, stack = true, close = true, cat = 'Huile', amount = 50, price = 5},
    ['gmr_igd_huile_colza'] = {label = 'Huile de colza', weight = 60, stack = true, close = true, cat = 'Huile', amount = 50, price = 5},
    ['gmr_igd_huile_noix'] = {label = 'Huile de noix', weight = 60, stack = true, close = true, cat = 'Huile', amount = 50, price = 5},
    ['gmr_igd_huile_sesame'] = {label = 'Huile de sésame', weight = 60, stack = true, close = true, cat = 'Huile', amount = 50, price = 5},

    -- Condiments et épices --
    ['gmr_igd_poivre'] = {label = 'Poivre', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_sel'] = {label = 'Sel', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_thym'] = {label = 'Thym', weight = 5, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_romarin'] = {label = 'Romarin', weight = 5, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_basilic'] = {label = 'Basilic', weight = 10, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_persil'] = {label = 'Persil', weight = 10, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_ciboulette'] = {label = 'Ciboulette', weight = 10, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_canelle'] = {label = 'Cannelle', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_vanille'] = {label = 'Vanille', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_cumin'] = {label = 'Cumin', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_curcuma'] = {label = 'Curcuma', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_paprika'] = {label = 'Paprika', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_safran'] = {label = 'Safran', weight = 1, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_poivre_noir'] = {label = 'Poivre noir', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_girofle'] = {label = 'Girofle', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_noix_de_muscade'] = {label = 'Noix de muscade', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_thym_frais'] = {label = 'Thym frais', weight = 5, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_curry'] = {label = 'Curry', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_feuille_de_laurier'] = {label = 'Feuille de laurier', weight = 1, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_sesame'] = {label = 'Sésame', weight = 10, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_lin'] = {label = 'Lin', weight = 10, stack = true, close = true, cat = 'Graines', amount = 50, price = 5},
    ['gmr_igd_pavot'] = {label = 'Pavot', weight = 5, stack = true, close = true, cat = 'Graines', amount = 50, price = 5},
    ['gmr_igd_coriandre'] = {label = 'Coriandre', weight = 10, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_estragon'] = {label = 'Estragon', weight = 5, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_galanga'] = {label = 'Galanga', weight = 15, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_fenugrec'] = {label = 'Fenugrec', weight = 10, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},
    ['gmr_igd_lavande'] = {label = 'Lavande', weight = 1, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ['gmr_igd_capre'] = {label = 'Câpre', weight = 1, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    
    -- Sauces et condiments liquides --
    ['gmr_igd_sauce_soja'] = {label = 'Sauce soja', weight = 50, stack = true, close = true, cat = 'Sauce', amount = 50, price = 5},
    ['gmr_igd_vinaigre'] = {label = 'Vinaigre', weight = 35, stack = true, close = true, cat = 'Condiment liquide', amount = 50, price = 5},
    ['gmr_igd_vinaigre_balsamique'] = {label = 'Vinaigre balsamique', weight = 40, stack = true, close = true, cat = 'Condiment liquide', amount = 50, price = 5},
    ['gmr_igd_vinaigre_vin'] = {label = 'Vinaigre de vin', weight = 40, stack = true, close = true, cat = 'Condiment liquide', amount = 50, price = 5},
    ['gmr_igd_vinaigre_cidre'] = {label = 'Vinaigre de cidre', weight = 40, stack = true, close = true, cat = 'Condiment liquide', amount = 50, price = 5},
    ['gmr_igd_ketchup'] = {label = 'Ketchup', weight = 35, stack = true, close = true, cat = 'Sauce', amount = 50, price = 5},
    ['gmr_igd_moutarde'] = {label = 'Moutarde', weight = 30, stack = true, close = true, cat = 'Sauce', amount = 50, price = 5},
    ['gmr_igd_mayonnaise'] = {label = 'Mayonnaise', weight = 40, stack = true, close = true, cat = 'Sauce', amount = 50, price = 5},

    -- Céréales, farines et graines --
    ['gmr_igd_farine'] = {label = 'Farine', weight = 50, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_ble'] = {label = 'Blé', weight = 50, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_sucre'] = {label = 'Sucre', weight = 40, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_farine_de_mais'] = {label = 'Farine de maïs', weight = 40, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_quinoa'] = {label = 'Quinoa', weight = 35, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_boulgour'] = {label = 'Boulgour', weight = 35, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_lentille'] = {label = 'Lentille', weight = 40, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_haricot'] = {label = 'Haricot', weight = 40, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_pois_chiche'] = {label = 'Pois chiche', weight = 45, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},
    ['gmr_igd_levure'] = {label = 'Levure', weight = 45, stack = true, close = true, cat = 'Céréales et farines', amount = 10, price = 5},

    -- Pâte --
    ['gmr_igd_penne'] = {label = 'Penne', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_macaroni'] = {label = 'Macaroni', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_spaghetti'] = {label = 'Spaghetti', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_fusilli'] = {label = 'Fusilli', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_tagliatelle'] = {label = 'Tagliatelle', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_rigatoni'] = {label = 'Rigatoni', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_farfalle'] = {label = 'Farfalle', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_lasagne'] = {label = 'Lasagne', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_orecchiette'] = {label = 'Orecchiette', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},
    ['gmr_igd_cavatappi'] = {label = 'Cavatappi', weight = 50, stack = true, close = true, cat = 'Pâte', amount = 10, price = 5},

    -- Riz --
    ['gmr_igd_riz_basmati'] = {label = 'Riz Basmati', weight = 40, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_jasmin'] = {label = 'Riz Jasmin', weight = 40, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_sauvage'] = {label = 'Riz Sauvage', weight = 45, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_gluant'] = {label = 'Riz Gluant', weight = 35, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_carnaroli'] = {label = 'Riz Carnaroli', weight = 40, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_arboreo'] = {label = 'Riz Arborio', weight = 40, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_complet'] = {label = 'Riz Complet', weight = 45, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_rouge'] = {label = 'Riz Rouge', weight = 40, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},
    ['gmr_igd_riz_noir'] = {label = 'Riz Noir', weight = 45, stack = true, close = true, cat = 'Riz', amount = 10, price = 5},

     -- Produits sucrés et boulangerie --
     ['gmr_igd_chocolat'] = {label = 'Chocolat', weight = 25, stack = true, close = true, cat = 'Sucré', amount = 10, price = 5},
     ['gmr_igd_biscuit'] = {label = 'Biscuit', weight = 20, stack = true, close = true, cat = 'Sucré', amount = 10, price = 5},
     ['gmr_igd_pain_d_epice'] = {label = 'Pain d\'épice', weight = 25, stack = true, close = true, cat = 'Sucré', amount = 10, price = 5},
     ['gmr_igd_brioche'] = {label = 'Brioche', weight = 30, stack = true, close = true, cat = 'Sucré', amount = 10, price = 5},
     ['gmr_igd_miel'] = {label = 'Miel', weight = 35, stack = true, close = true, cat = 'Sucré', amount = 10, price = 5},
     ["gmr_igd_glace"] = {label = 'Glace', weight = 50, stack = true, close = true, cat = 'Sucré', amount = 10, price = 5},
 
     -- Produits transformés et plats préparés --
     ['gmr_igd_bouillon'] = {label = 'Bouillon', weight = 10, stack = true, close = true, cat = 'Produit transformé', amount = 10, price = 5},
     ['gmr_igd_chorizo'] = {label = 'Chorizo', weight = 30, stack = true, close = true, cat = 'Produit transformé', amount = 10, price = 5},
     ['gmr_igd_harissa'] = {label = 'Harissa', weight = 15, stack = true, close = true, cat = 'Produit transformé', amount = 10, price = 5},
 
     -- Fruits secs et oléagineux --
     ['gmr_igd_noix'] = {label = 'Noix', weight = 20, stack = true, close = true, cat = 'Fruit sec', amount = 10, price = 5},
     ['gmr_igd_amande'] = {label = 'Amande', weight = 20, stack = true, close = true, cat = 'Fruit sec', amount = 10, price = 5},
     ['gmr_igd_pistache'] = {label = 'Pistache', weight = 15, stack = true, close = true, cat = 'Fruit sec', amount = 10, price = 5},
     ['gmr_igd_noisette'] = {label = 'Noisette', weight = 20, stack = true, close = true, cat = 'Fruit sec', amount = 10, price = 5},
     ['gmr_igd_cacahuete'] = {label = 'Cacahuète', weight = 15, stack = true, close = true, cat = 'Fruit sec', amount = 10, price = 5},
     ['gmr_igd_poudre_d_amande'] = {label = 'Poudre d\'amande', weight = 20, stack = true, close = true, cat = 'Fruit sec', amount = 10, price = 5},
     ['gmr_igd_poudre_de_noisette'] = {label = 'Poudre de noisette', weight = 20, stack = true, close = true, cat = 'Fruit sec', amount = 10, price = 5},
 
     -- Divers --
     ['gmr_igd_tofu'] = {label = 'Tofu', weight = 45, stack = true, close = true, cat = 'Divers', amount = 10, price = 5},
     ['gmr_igd_ginseng'] = {label = 'Ginseng', weight = 5, stack = true, close = true, cat = 'Divers', amount = 10, price = 5},
     ['gmr_igd_tomate_sechee'] = {label = 'Tomate séchée', weight = 20, stack = true, close = true, cat = 'Divers', amount = 10, price = 5},
     ["gmr_igd_herbes_magiques"] = {label = 'Herbes magiques', weight = 10, stack = true, close = true, cat = 'Divers', amount = 10, price = 5},
     ["gmr_igd_the"] = {label = 'Thé', weight = 5, stack = true, close = true, cat = 'Divers', amount = 5, price = 5},
     ["gmr_igd_the_vert"] = {label = 'Thé vert', weight = 5, stack = true, close = true, cat = 'Divers', amount = 5, price = 5},
     ["gmr_igd_the_noir"] = {label = 'Thé noir', weight = 5, stack = true, close = true, cat = 'Divers', amount = 5, price = 5},
     ["gmr_igd_the_blanc"] = {label = 'Thé blanc', weight = 5, stack = true, close = true, cat = 'Divers', amount = 5, price = 5},
     ["gmr_igd_cafe"] = {label = 'Café', weight = 5, stack = true, close = true, cat = 'Divers', amount = 5, price = 5},
 
     -- Japonnais --
     ['gmr_igd_nori'] = {label = 'Algue Nori', weight = 5, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_shoyu'] = {label = 'Sauce soja (Shoyu)', weight = 40, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_mirin'] = {label = 'Mirin', weight = 30, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_dashi'] = {label = 'Dashi', weight = 10, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_wasabi'] = {label = 'Wasabi', weight = 10, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_sake'] = {label = 'Saké', weight = 50, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_udon'] = {label = 'Nouilles Udon', weight = 45, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_soba'] = {label = 'Nouilles Soba', weight = 40, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_miso'] = {label = 'Miso', weight = 20, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},
     ['gmr_igd_gingembre_marine'] = {label = 'Gingembre mariné', weight = 15, stack = true, close = true, cat = 'Japonais', amount = 10, price = 5},

    -- Alcool autre --
    ['gmr_igd_vin_blanc'] = {label = 'Vin blanc', weight = 60, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_vin_rouge'] = {label = 'Vin rouge', weight = 60, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_vin_rose'] = {label = 'Vin rosé', weight = 60, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_cognac'] = {label = 'Cognac', weight = 55, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_rhum'] = {label = 'Rhum', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_madeira'] = {label = 'Madère', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_porto'] = {label = 'Porto', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_marsala'] = {label = 'Marsala', weight = 55, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},
    ['gmr_igd_cidre'] = {label = 'Cidre', weight = 45, stack = true, close = true, cat = 'Alcool', amount = 1, price = 10},

    -- Alcool bière -- 
    ["gmr_igd_biere"] = {label = 'Bière', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_blonde"] = {label = 'Bière blonde', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_brune"] = {label = 'Bière brune', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_ambree"] = {label = 'Bière ambree', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_ipa"] = {label = 'Bière IPA', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_stout"] = {label = 'Bière stout', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_lager"] = {label = 'Bière lager', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_pilsner"] = {label = 'Bière pilsner', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_triple"] = {label = 'Bière triple', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_saison"] = {label = 'Bière saison', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_weizen"] = {label = 'Bière weizen', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_porter"] = {label = 'Bière porter', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_gueuze"] = {label = 'Bière gueuze', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_blanche"] = {label = 'Bière blanche', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},
    ["gmr_igd_biere_fruitee"] = {label = 'Bière fruitée', weight = 50, stack = true, close = true, cat = 'Alcool', amount = 10, price = 50},

    -- Boisson --
    ['gmr_igd_sprunk'] = {label = 'Sprunk', weight = 50, stack = true, close = true, cat = 'Soda', amount = 10, price = 50},
    ['gmr_igd_ecola'] = {label = 'E-Cola', weight = 50, stack = true, close = true, cat = 'Soda', amount = 10, price = 50},

    -- Divers --
    ["gmr_igd_chapelure"] = {label = 'Chapelure', weight = 10, stack = true, close = true, cat = 'Céréales et farines', amount = 50, price = 5},
    
    ["gmr_igd_herbes_provence"] = {label = 'Herbes de Provence', weight = 10, stack = true, close = true, cat = 'Herbe', amount = 50, price = 5},
    ["gmr_igd_piment_doux"] = {label = 'Piment doux', weight = 5, stack = true, close = true, cat = 'Épice', amount = 50, price = 5},

    -- #################################################################################################### --
    -- ## Début de Section - Produits issus du vignoble Mancini ## --
    -- #################################################################################################### --

    -- Vins d'exception --
    ["gmwine_rouge1"] = {label = "Don Gaïus",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_rose1"] = {label = "Coeur de Bianca",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_blanc1"] = {label = "Bianco di Mancini",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_champ1"] = {label = "Cuvée Gaïus",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},

    -- Vins remarquables --
    ["gmwine_rouge2"] = {label = "Terra di Sicilia",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_rose2"] = {label = "Val di Noto Rosa",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_blanc2"] = {label = "Sole di Palermo",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_champ2"] = {label = "Blanc de Blancs Mancini",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},

    -- Vins standards --
    ["gmwine_rouge3"] = {label = "Vinewood Velour",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_rose3"] = {label = "Los Santos Sunset",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_blanc3"] = {label = "Grapeseed Sensation",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_champ3"] = {label = "Vespucci Glamour Gold",weight = 500,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},

    -- Soft --
    ["gmwine_jusderaisin"] = {label = "Grappe'licious",weight = 250,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},
    ["gmwine_jusderaisinpetillant"] = {label = "Grappe'licious Frizzante",weight = 250,stack = true,close = true,cat = 'Produit Mancini',  amount = 1, price = 1000},

    -- #################################################################################################### --
    -- ## Fin de Section - Produits issus du vignoble Mancini ## --
    -- #################################################################################################### --

    -- #################################################################################################### --
    -- ## Début de Section - Produits issus de la ferme ## --
    -- #################################################################################################### --

    ["gmr_igd_jus_de_pomme"] = {label = "Jus de pomme",weight = 500,stack = true,close = true,cat = 'Produit de la ferme',  amount = 1, price = 1000},
    ["gmr_igd_jus_d_orange"] = {label = "Jus d'orange",weight = 500,stack = true,close = true,cat = 'Produit de la ferme', amount = 1, price = 1000},
    ["gmr_igd_jus_de_tomate"] = {label = "Jus de tomate",weight = 500,stack = true,close = true,cat = 'Produit de la ferme', amount = 1, price = 1000},

    -- #################################################################################################### --
    -- ## Fin de Section - Produits issus de la ferme ## --
    -- #################################################################################################### --    

    -- #################################################################################################### --
    -- ## Début de Section - Sumol ## --
    -- #################################################################################################### --

    ["sumol"] = {label = "sumol",weight = 500,stack = true,close = true,cat = 'Produit de sumol', amount = 1, price = 1000},

    -- #################################################################################################### --
    -- ## Fin de Section - Sumol ## --
    -- #################################################################################################### --

}


IngList.Player = {
    -- ['apple'] = {item = "gmr_igd_pomme",amount = 10},
    -- Veut dire 1*apple = 10*gmr_igd_pomme
    -- Item de la ferme --
    ['apple'] = {item = "gmr_igd_pomme",amount = 10},
    ['orange'] = {item = "gmr_igd_orange",amount = 10},
    ['mushroom'] = {item = "gmr_igd_champignon",amount = 10},
    ['pumpkin'] = {item = "gmr_igd_citrouille",amount = 10},
    ['cabbage'] = {item = "gmr_igd_chou",amount = 10},
    ['tomato'] = {item = "gmr_igd_tomate",amount = 10},
    ['pig'] = {item = "gmr_igd_porc",amount = 10},
    ['cow'] = {item = "gmr_igd_boeuf",amount = 10},
    ['hen'] = {item = "gmr_igd_poulet",amount = 10},
    ['milk'] = {item = "gmr_igd_lait",amount = 10},
    ['wheat'] = {item = "gmr_igd_ble",amount = 10},

    ['pineapple'] = {item = "gmr_igd_ble",amount = 10},
    ['mangue'] = {item = "gmr_igd_ble",amount = 10},
    ['maracuya'] = {item = "gmr_igd_ble",amount = 10},

    ['jusorange'] = {item = "gmr_igd_jus_de_pomme",amount = 1},
    ['juspommes'] = {item = "gmr_igd_jus_d_orange",amount = 1},
    ['justomates'] = {item = "gmr_igd_jus_de_tomate",amount = 1},

    ['sumol'] = {item = "gmr_igd_ble",amount = 1},
    

    -- Item du Domaine Mancini --
    -- Vins d'exception --
    ["gmwine_rouge1"] = {item = "gmwine_rouge1", amount = 2},
    ["gmwine_rose1"] = {item = "gmwine_rose1", amount = 2},
    ["gmwine_blanc1"] = {item = "gmwine_blanc1", amount = 2},
    ["gmwine_champ1"] = {item = "gmwine_champ1", amount = 2},

    -- Vins remarquables --
    ["gmwine_rouge2"] = {item = "gmwine_rouge2", amount = 2},
    ["gmwine_rose2"] = {item = "gmwine_rose2", amount = 2},
    ["gmwine_blanc2"] = {item = "gmwine_blanc2", amount = 2},
    ["gmwine_champ2"] = {item = "gmwine_champ2", amount = 2},

    -- Vins standards --
    ["gmwine_rouge3"] = {item = "gmwine_rouge3", amount = 2},
    ["gmwine_rose3"] = {item = "gmwine_rose3", amount = 2},
    ["gmwine_blanc3"] = {item = "gmwine_blanc3", amount = 2},
    ["gmwine_champ3"] = {item = "gmwine_champ3", amount = 2},

    -- Soft --
    ["gmwine_jusderaisin"] = {item = "gmwine_jusderaisin", amount = 1},
    ["gmwine_jusderaisinpetillant"] = {item = "gmwine_jusderaisinpetillant", amount = 1},
}

IngList.Compo = {

    
}

RegisterNetEvent('gm-restaurant:server:delivery:rewardPlayer')
AddEventHandler('gm-restaurant:server:delivery:rewardPlayer', function(amount, itemCount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney('cash', amount)
    local amountJob = (amount- (amount%2))/2 -- la moitié
    exports['okokBanking']:AddMoney(xPlayer.job.name, amountJob)
end)

/* Pour les logs des courses :

okokbanking_transactions
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`receiver_identifier` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- job
	`receiver_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- jopizza (Custom)
	`sender_identifier` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- "Commande"
	`sender_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- Ingrédients
	`date` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- 2024-10-22 22:14:35
	`value` INT(50) NOT NULL, -- montant
	`type` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_general_ci', -- "transfer"

*/
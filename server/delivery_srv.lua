RegisterNetEvent('gm-restaurant:server:delivery:rewardPlayer')
AddEventHandler('gm-restaurant:server:delivery:rewardPlayer', function(amount, itemCount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney('cash', amount)
    local amountJob = (amount- (amount%2))/2 -- la moitieé
    exports.fdsdev_bossmenu.addMoney(nil, Config.Job, amountJob,"Livraison")
end)

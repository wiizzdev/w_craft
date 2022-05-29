ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('craft:craftitem')
AddEventHandler('craft:craftitem', function(item, nameitem, ing1, ing2, color)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(ing1).count >= 1 and xPlayer.getInventoryItem(ing2).count >= 1 then
        xPlayer.removeInventoryItem(ing1, 1)
        xPlayer.removeInventoryItem(ing2, 1)
        xPlayer.addInventoryItem(nameitem, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez fabriqué un "..color..""..item)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Il vous manque des ingrédients")  
    end
end)

RegisterServerEvent('craft:craftarme')
AddEventHandler('craft:craftarme', function(arme, namearme, ing1, ing2, color)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(ing1).count >= 1 and xPlayer.getInventoryItem(ing2).count >= 1 then
        xPlayer.removeInventoryItem(ing1, 1)
        xPlayer.removeInventoryItem(ing2, 1)
        xPlayer.addWeapon(namearme, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez fabriqué un "..color..""..arme)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Il vous manque des ingrédients")  
    end
end)
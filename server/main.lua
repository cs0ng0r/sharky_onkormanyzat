

RegisterNetEvent('sharky_onkori:giveitem')
AddEventHandler('sharky_onkori:giveitem', function(source, item)
    local src = source

    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        return
    end

    if item ~= Config.Items.idcarditem and item ~= Config.Items.driveritem and item ~= Config.Items.weaponitem then
        return --[[ ban logic here]]
    end

    xPlayer.addInventoryItem(item, 1)
end)

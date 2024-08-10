RegisterNetEvent('sharky_onkori:giveitem')
AddEventHandler('sharky_onkori:giveitem', function(source, item)
    local src = source

    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        return
    end

    xPlayer.addInventoryItem(item, 1)
end)

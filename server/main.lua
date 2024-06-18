ESX = exports['es_extended']:getSharedObject()

for k, v in pairs(Config.License) do
    local hasAccess = v
    return hasAccess
end


RegisterNetEvent('sharky_onkori:giveitem')
AddEventHandler('sharky_onkori:giveitem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return
    end

    xPlayer.addInventoryItem(item, 1)
end)

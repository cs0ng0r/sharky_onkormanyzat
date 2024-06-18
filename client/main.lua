ESX = exports['es_extended']:getSharedObject()


lib.registerContext({
    id = 'onkori',
    title = 'Iratok Igénylése',
    options = {
        {
            title = 'Személyi Igazolvány',
            description = 'Személyi igazolvány kiadása',
            icon = 'id-card',
            onSelect = function()
                TriggerServerEvent('sharky_onkori:giveitem', Config.Items.idcarditem)
            end,

        },
        {
            title = 'Vezetői Engedély',
            description = 'Vezetői engedély kiadása',
            icon = 'id-card',
            onSelect = function()
                TriggerServerEvent('sharky_onkori:giveitem', Config.Items.driveritem)
            end,

        },
        {
            title = 'Fegyver Engedély',
            description = 'Fegyver engedély kiadása',
            icon = 'id-card',
            onSelect = function()
                TriggerServerEvent('sharky_onkori:giveitem', Config.Items.weaponitem)
            end,

        },
    }
})

-- Spawn ped
Citizen.CreateThread(function()
    local hash = GetHashKey(Config.Government.ped)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    ped = CreatePed(4, hash, Config.Government.location, Config.Government.heading, false, true)
end)


-- Felirat megjelenítése ped felett

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pedCoords = GetEntityCoords(ped)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(pedCoords - playerCoords)
        if distance < 10 then
            DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 1.0, "Igénylés ~b~[Dokumentum]")
            if distance < 1.5 and IsControlJustPressed(0, 38) then
                lib.openContext('onkori')
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

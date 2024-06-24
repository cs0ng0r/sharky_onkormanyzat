ESX = exports['es_extended']:getSharedObject()


AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if ped then
            DeleteEntity(ped)
        end
    end
end)

function checklicencebytype(type)
    ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
        if hasLicense then
            return true
        else
            return false
        end
    end, GetPlayerServerId(PlayerId()), type)
end

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
                
                ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
                    if hasDriversLicense then
                        TriggerServerEvent('sharky_onkori:giveitem', Config.Items.driveritem)
                    else
                        ESX.ShowNotification('Nincs jogosítványod!')
                    end
                end, GetPlayerServerId(PlayerId()), 'drive')
            end,

        },
        {
            title = 'Fegyver Engedély',
            description = 'Fegyver engedély kiadása',
            icon = 'id-card',
            disabled = checklicencebytype('weapon'),
            onSelect = function()
                
                ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponsLicense)
                    if hasWeaponsLicense then
                        TriggerServerEvent('sharky_onkori:giveitem', Config.Items.weaponitem)
                    else
                        ESX.ShowNotification('Nincs jogosítványod!')
                    end
                end, GetPlayerServerId(PlayerId()), 'weapon')
            end,

        },
    }
})

CreateThread(function()
    local hash = GetHashKey(Config.Government.ped)
    lib.requestModel(hash, 10000)
    ped = CreatePed(4, hash, Config.Government.location, Config.Government.heading, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    local zone = lib.zones.sphere({
        coords = Config.Government.location,
        radius = 3.5,
        debug = false,
        inside = function()
            DrawText3D(Config.Government.location + vec3(0, 0, 2), 'Igénylés ~b~[Dokumentumok]')
        end
    })
    exports.ox_target:addSphereZone({
        coords = Config.Government.location,
        radius = 3.5,
        debug = false,
        drawSprite = false,
        options = {
            {
                label = 'Iratok Igénylése',
                icon = 'fa-solid fa-id-card',
                onSelect = function()
                    lib.showContext('onkori')
                end
            }
        }
    })
end)

function DrawText3D(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.0, 0.4)
    SetTextFont(4)
    SetTextCentre(1)
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(0, 0)
    ClearDrawOrigin()
end

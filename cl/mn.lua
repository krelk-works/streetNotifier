local threads = {street=false}

AddEventHandler('playerSpawned', function()
    if not threads.street then
        startStreetThread()
        threads.street = true
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        if not threads.street then
            startStreetThread()
            threads.street = true
        end
    end
end)

function startStreetThread()
    dprint('Street Name started...') Citizen.Wait(100)
    SendNUIMessage({Configs = {streetTranslate = Config.Translate, emoji = Config.Emoji, Debug = Config.Debug, TimeToShow = Config.TimeToShow}})
    Citizen.CreateThread(function()
        local currentStreet = nil
        while true do
            local position = GetEntityCoords(GetPlayerPed(-1)) local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            if currentStreet == nil or currentStreet ~= streetName then dprint("You are on " .. streetName) SendNUIMessage({newStreet = streetName}) currentStreet = streetName end Citizen.Wait(Config.Sleep)
        end
    end)
end

function dprint(text)
    if Config.Debug then
        print(text)
    end
end
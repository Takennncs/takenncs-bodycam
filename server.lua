local QBCore = exports['qb-core']:GetCoreObject()

local playerBodycamState = {}

RegisterNetEvent("booleanuodate")
AddEventHandler("booleanuodate", function(state)
    local src = source
    playerBodycamState[src] = state
end)

QBCore.Functions.CreateUseableItem("bodycam", function(source, item)
    local hour = tonumber(os.date("%H"))
    local min = tonumber(os.date("%M"))
    local sec = tonumber(os.date("%S"))
    TriggerClientEvent("takenncs-bodycam:openBoy", source, item, hour, min, sec)
end)

if Config.Debug then
    QBCore.Commands.Add('debugbodycam', 'debugging takenncs-bodycam', {}, false, function(source, args)
        local hour = tonumber(os.date("%H"))
        local min = tonumber(os.date("%M"))
        local sec = tonumber(os.date("%S"))
        TriggerClientEvent("takenncs-bodycam:openBoy", source, nil, hour, min, sec)
    end)
end

CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for src, isActive in pairs(playerBodycamState) do
            if isActive then
                local hour = tonumber(os.date("%H"))
                local min = tonumber(os.date("%M"))
                local sec = tonumber(os.date("%S"))
                TriggerClientEvent("bodycam:time", src, hour, min, sec)
            end
        end
    end
end)

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local acik = false
local position = "right" 

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent("bodycam:time")
AddEventHandler("bodycam:time", function(h, m, s)
    local year, month, day = GetLocalTime()
    SendNUIMessage({
        action = "zamanguncelle",
        zaman = string.format("%02d/%02d/%04d - %02d:%02d:%02d GMT+3", day, month, year, h, m, s)
    })
end)

RegisterNetEvent("takenncs-bodycam:openBoy")
AddEventHandler("takenncs-bodycam:openBoy", function(item, h, m, s)
    local Player = QBCore.Functions.GetPlayerData()

    if Player.job and Player.job.name == "police" then
        local gender = (Player.charinfo.gender == "0") and Config.Gender2 or Config.Gender1
        local jobLabel = Player.job.label or "Politsei"
        local grade = Player.job.grade or 0
        local gradeLabel = Player.job.grade_label or ("Ametnik " .. tostring(grade))
        local year, month, day = GetLocalTime()

        if acik then
            acik = false
            ClearPedTasks(PlayerPedId())
            SendNUIMessage({ action = "hidebodycam" })

            ExecuteCommand('me Lülitas bodycami välja')

            TriggerEvent("QBCore:Notify", "Lülitasid bodycami välja!", "success", 2500)
            TriggerServerEvent("booleanuodate", false)
        else

            SendNUIMessage({
                action = "showbodycam",
                player = string.format("%s %s %s", gradeLabel, gender, Player.charinfo.lastname),
                callsign = "[" .. (Player.metadata['callsign'] or "N/A") .. "]",
                tarih = string.format("%02d/%02d/%04d - %02d:%02d:%02d GMT+3", day, month, year, h, m, s),
                position = position 
            })

            ExecuteCommand('me Lülitas bodycami sisse')

            TriggerEvent("QBCore:Notify", "Lülitasid bodycami sisse!", "success", 2500)
            TriggerServerEvent("booleanuodate", true)
            acik = true
        end
    else
        TriggerEvent("QBCore:Notify", "Sa ei kuulu fraktsiooni, et seda kasutada!", "error", 3000)
        TriggerServerEvent('ox_inventory:removeItem', item, 1)
    end
end)


RegisterCommand("bodycam", function()
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job and Player.job.name == "police" then
        local options = {
            {
                title = "Pane bodycam paremale",
                description = "Aseta bodycam paremale küljele",
                event = "takenncs-bodycam:setPosition",
                args = "right"
            },
            {
                title = "Pane bodycam vasakule",
                description = "Aseta bodycam vasakule küljele",
                event = "takenncs-bodycam:setPosition",
                args = "left"
            },
            {
                title = "Lülita bodycam välja",
                description = "Sulge bodycam kuvamine",
                event = "takenncs-bodycam:toggleOff",
            }
        }

        lib.registerContext({
            id = 'bodycam_menu',
            title = 'Bodycam valikud',
            options = options
        })

        lib.showContext('bodycam_menu')
    else
        QBCore.Functions.Notify("Sa ei kuulu politsei fraktsiooni!", "error")
    end
end)

RegisterNetEvent("takenncs-bodycam:setPosition")
AddEventHandler("takenncs-bodycam:setPosition", function(pos)
    position = pos
    if acik then

        SendNUIMessage({ action = "updatePosition", position = pos })
        QBCore.Functions.Notify("Bodycam liigutatud " .. pos, "success")
    else
        QBCore.Functions.Notify("Bodycam pole sees!", "error")
    end
end)

RegisterNetEvent("takenncs-bodycam:toggleOff")
AddEventHandler("takenncs-bodycam:toggleOff", function()
    if acik then
        acik = false
        SendNUIMessage({ action = "hidebodycam" })
        QBCore.Functions.Notify("Bodycam välja lülitatud", "success")
    else
        QBCore.Functions.Notify("Bodycam ei olnud sees", "error")
    end
end)

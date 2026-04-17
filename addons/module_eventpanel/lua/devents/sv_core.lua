-- 17.04
dEvents.events = {}

--[[
    eventData:
        int startTime - Время перед началом ивента
        int maxMembers - Максимальное кол-во участников на ивенте ((C# оказывает на меня неотвратимое влияние))
        table strip - Перечислить свепы для выдачи / Оставить пустой для полного стрипа / Не указывать, чтобы оставить все, как есть
        table positions - Перечисляем позиции для телепорта игроков
        bool respawn - Возвращать ли игроков на ивент после смерти или кикать
        table blacklistedJobs - Профессии, с которыми нельзя будет подключиться к ивенту
    ]]

function dEvents.initEvent(eventer, data)
    local canStart, reason = dEvents.canStartEvent(eventer)
    if canStart == false then return DarkRP.notify(eventer, 1, 4, reason) end

    local eventerId = eventer:SteamID()

    dEvents.events[eventerId] = {
        startTime = data.startTime and data.startTime >= dEvents.config.startTime.min and data.startTime <= dEvents.config.startTime.max and data.startTime or dEvents.config.startTime.default,
        maxMembers = data.maxMembers and data.maxMembers >= dEvents.config.maxMembers.min and data.maxMembers <= dEvents.config.maxMembers.max and data.maxMembers or dEvents.config.maxMembers.default,
        strip = data.strip,
        positions = data.positions or eventer:GetPos(),
        respawn = data.respawn,
        blacklistedJobs = data.blacklistedJobs,
        
        started = false,

        joinMembers = {},
        members = {},
    }

    DarkRP.notify(eventer, 0, 4, dEvents.getPhrase('hint_eventStarted'))
    dEvents.notifyAll(Color(255,255,255), string.format('Администратор %s(%s) запустил ивент. Команда для подключения: /go', eventer:Name(), eventer:SteamID()))
    hook.Run('dEvents.eventStart', eventer)

    timer.Create('dEvents.start_'..eventerId, dEvents.getEventTable(eventer).startTime, 1, function ()
        if not IsValid(eventer) then return dEvents.stopEvent(eventerId) end

        local eventTable = dEvents.getEventTable(eventer)
        local joinMembers = table.Count(eventTable.joinMembers)

        local checksPass = true
        local errorMSG

        -- Проверка на минимум участников
        if joinMembers < dEvents.config.minEventMembers then
            errorMSG = dEvents.getPhrase('error_lowMembers')
            checksPass = false
        end

        dEvents.notifyAll(Color(255,255,255), string.format('Ивент от %s начался. Команда /go перестала существовать.', eventer:Name()))
        if not checksPass then
            DarkRP.notify(eventer, 1, 4, errorMSG)
            for sid, _ in pairs (eventTable.joinMembers) do
                DarkRP.notify(player.GetBySteamID(sid), 1, 4, errorMSG)
            end
            return dEvents.stopEvent(eventerId)
        end

        for k, _ in pairs (eventTable.joinMembers) do
            local pl = player.GetBySteamID(k)
            if not IsValid(pl) then continue end
            dEvents.addEventMember(pl, eventer:SteamID())
            dEvents.teleportToEvent(pl)
            dEvents.notify(pl, Color(255,255,255), dEvents.getPhrase('hint_teleported'))
        end

        eventTable.joinMembers = {}
        eventTable.started = true

        dEvents.sendEventTable(eventer)
    end)
end

function dEvents.stopEvent(eventer)
    if not eventer then return end
    local id = isstring(eventer) and eventer or eventer:SteamID()
    local eventer = player.GetBySteamID(id)

    for sid, info in pairs (dEvents.getEventMembers(id) or {}) do
        local ply = player.GetBySteamID(sid)
        if IsValid(ply) then
            dEvents.removeEventMember(ply)
            DarkRP.notify(ply, 0, 4, dEvents.getPhrase('hint_eventEnded'))
        end
    end

    if dEvents.events[id] and IsValid(eventer) then hook.Run('dEvents.eventEnd', eventer) end
    dEvents.events[id] = nil
    dEvents.sendEventTable(eventer)
end

function dEvents.stripWeapons(ply, strip)
    if not IsValid(ply) then return end

    if not strip then return
    else
        ply:StripWeapons()
        for _, v in pairs (strip) do
            local tbl = weapons.Get(v)
            if not dEvents.config.permittedCategories[tbl and tbl.Category or ''] and not dEvents.config.permittedWeapons[v] then continue end
            local wep = ply:Give(v)
            if IsValid(wep) then wep:SetVar('restricted_to_drop', true) end
        end
    end
end

function dEvents.teleportToEvent(ply)
    if not IsValid(ply) then return end

    local eventId = dEvents.getEventer(ply)
    if not eventId then return end

    local event = dEvents.getEventTable(eventId)

    dEvents.stripWeapons(ply, event.strip)

    local _, hull = ply:GetHull()

    local pos = event.positions[math.random(1, #event.positions)]
    pos = isvector(pos) and pos or player.GetBySteamID(eventId):GetPos()
    ply:SetPos(DarkRP.findEmptyPos(pos, {ply}, 600, 20, hull))

    ply:SetViewOffset(Vector(0, 0, 64) * ply:GetModelScale())
    ply:SetViewOffsetDucked(Vector(0, 0, 28) * ply:GetModelScale())
end

function dEvents.addEventMember(ply, eventId)
    if not IsValid(ply) then return end

    if dEvents.getEventer(ply) then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_inEvent')) end
    if dEvents.getEventTable(ply:SteamID()) then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_eventFounder')) end
    if ply:isArrested() then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_arrested')) end
    local eventTable = dEvents.getEventTable(eventId)
    if not eventTable then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_eventNotExist')) end

    if table.Count(eventTable.members) > eventTable.maxMembers then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_eventFull')) end

    local weapons = {}
    for _, v in pairs (ply:GetWeapons()) do
        table.insert(weapons, v:GetClass())
    end

    eventTable.members[ply:SteamID()] = {
        speed = {
            run = ply:GetRunSpeed(),
            walk = ply:GetWalkSpeed(),
            jump = ply:GetJumpPower(),
        },
        status = {
            health = ply:Health(),
            armor = ply:Armor(),
            model = ply:GetModel(),
            scale = ply:GetModelScale(),
        },
        position = ply:GetPos(),
        weapons = weapons,
        team = ply:Team(),
    }
end

function dEvents.joinEvent(ply, eventId)
    if not IsValid(ply) then return end

    if dEvents.getEventer(ply) then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_inEvent')) end
    if dEvents.isPreparing(ply) then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_joining')) end
    if dEvents.getEventTable(ply:SteamID()) then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_eventFounder')) end
    if ply:isArrested() then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_arrested')) end
    local eventTable = dEvents.getEventTable(eventId)
    if not eventTable then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_eventNotExist')) end

    if table.Count(eventTable.joinMembers) > eventTable.maxMembers then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_eventFull')) end

    eventTable.joinMembers[ply:SteamID()] = true
    DarkRP.notify(ply, 0, 4, dEvents.getPhrase('hint_joined'))
end

function dEvents.removeEventMember(ply)
    if not IsValid(ply) then return end
    local eventId = dEvents.getEventer(ply)
    
    if not eventId then return end

    local eventTable = dEvents.getEventTable(eventId)
    local playerInfo = eventTable.members[ply:SteamID()]

    eventTable.members[ply:SteamID()] = nil
    dEvents.sendEventTable(player.GetBySteamID(eventId))

    if table.IsEmpty(eventTable.members) then
        dEvents.stopEvent(eventId)
    end

    timer.Simple(.1, function ()
        if not IsValid(ply) then return end

        ply:Spawn()
        ply:SetRunSpeed(playerInfo.speed.run or 600)
        ply:SetWalkSpeed(playerInfo.speed.walk or 400)
        ply:SetJumpPower(playerInfo.speed.jump or 200)
        local defaultModel = RPExtraTeams[ply:Team()].model
        ply:SetModel(playerInfo.status.model or (isstring(defaultModel) and defaultModel or defaultModel[1]))
        ply:SetHealth(playerInfo.status.health or 100)
        ply:SetArmor(playerInfo.status.armor or 0)
        ply:SetPos(playerInfo.position or Vector(0,0,0))
        ply:SetModelScale(playerInfo.status.scale or 1, 0)
        ply:SetViewOffset(Vector(0, 0, 64) * (playerInfo.status.scale or 1))
        ply:SetViewOffsetDucked(Vector(0, 0, 28) * (playerInfo.status.scale or 1))
        
        ply:StripWeapons()
        for _, v in pairs (playerInfo.team == ply:Team() and playerInfo.weapons or RPExtraTeams[ply:Team()].weapons or {}) do
            ply:Give(v)
        end
    end)
end

function dEvents.getEventer(ply)
    if not IsValid(ply) then return end
    for id, v in pairs (dEvents.events) do
        if v.members[ply:SteamID()] then return id end
    end
end

function dEvents.getEventMembers(eventer)
    local id = isstring(eventer) and eventer or eventer:SteamID()
    if not dEvents.getEventTable(id) then return end

    return dEvents.events[id].members
end

function dEvents.getEventTable(eventer)
    local id = isstring(eventer) and eventer or eventer:SteamID()

    return dEvents.events[id]
end

function dEvents.getFreeEvents()
    local free = {}
    for id, v in pairs (dEvents.events) do
        if not v.started then table.insert(free, id) end
    end
    return free
end

function dEvents.isPreparing(ply)
    local id = isstring(ply) and ply or ply:SteamID()
    local preparing = false
    for eventId, v in pairs (dEvents.events) do
        if v.joinMembers[id] then preparing = true end
    end
    return preparing
end

concommand.Add('go', function (ply)
    local eventer = dEvents.getFreeEvents()[1]

    if not eventer then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_noEvents')) end
    dEvents.joinEvent(ply, eventer)
end)

concommand.Add('leave', function (ply)
    local eventId = dEvents.getEventer(ply)
    if not eventId then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_notInEvent')) end

    dEvents.removeEventMember(ply)
    DarkRP.notify(ply, 0, 4, dEvents.getPhrase('hint_left'))
end)

hook.Add('PlayerSpawn', 'dEvents.respawn', function (ply)
    local eventId = dEvents.getEventer(ply)
    if not eventId then return end

    timer.Simple(.5, function ()
        if dEvents.getEventTable(eventId).respawn then
            dEvents.teleportToEvent(ply)
            DarkRP.notify(ply, 0, 4, dEvents.getPhrase('hint_respawned'))
        else
            dEvents.removeEventMember(ply)
            DarkRP.notify(ply, 0, 4, dEvents.getPhrase('hint_died'))
        end
    end)
end)

hook.Add('PlayerDisconnected', 'dEvents.disconnected', function (ply)
    if dEvents.getEventTable(ply:SteamID()) then
        dEvents.stopEvent(ply:SteamID())
    elseif dEvents.getEventer(ply) then
        dEvents.removeEventMember(ply)
    end
end)

hook.Add('playerArrested', 'dEvents.arrestKick', function (ply)
    if dEvents.getEventer(ply) then
        dEvents.removeEventMember(ply)
        DarkRP.notify(ply, 1, 4, dEvents.getPhrase('hint_arrested'))
    end
end)

hook.Add('Initialize', 'dEvents.pLogs', function ()
    plogs.Register('dEvents', true, Color(128,0,179))

    plogs.AddHook('dEvents.commandExecuted', function (ply, cmd, targets, args)
        if #targets == 0 then return end
        local str
        local copy

        if #targets > 1 then
            copy = {
                ['Eventer Name'] = ply:Name(),
                ['Eventer SteamID'] = ply:SteamID(),
                ['Command'] = cmd,
            }
            table.remove(args, 1)
            str = dEvents.getPhrase('log_usedCMD', ply:Name(), ply:SteamID(), cmd, 'all', table.concat(args, ', '))
        else
            local target = targets[1]
            copy = {
                ['Eventer Name'] = ply:Name(),
                ['Eventer SteamID'] = ply:SteamID(),
                ['Target Name'] = target:Name(),
                ['Target SteamID'] = target:SteamID(),
                ['Command'] = cmd,
            }
            table.remove(args, 1)
            str = dEvents.getPhrase('log_usedCMD', ply:Name(), ply:SteamID(), cmd, target:Name()..'('..target:SteamID()..')', table.concat(args, ', '))
        end
        plogs.PlayerLog(ply, 'dEvents', str, copy)
    end)

    plogs.AddHook('dEvents.eventEnd', function (ply)
        local copy = {
            ['Eventer Name'] = ply:Name(),
            ['Eventer SteamID'] = ply:SteamID(),
        }

        local str = dEvents.getPhrase('log_eventEnd', ply:Name(), ply:SteamID())

        plogs.PlayerLog(ply, 'dEvents', str, copy)
    end)
    
    plogs.AddHook('dEvents.eventStart', function (ply)
        local copy = {
            ['Eventer Name'] = ply:Name(),
            ['Eventer SteamID'] = ply:SteamID(),
        }

        local str = dEvents.getPhrase('log_eventStart', ply:Name(), ply:SteamID())

        plogs.PlayerLog(ply, 'dEvents', str, copy)
    end)

    plogs.cfg.CommandBlacklist['devents'] = true
    plogs.cfg.CommandBlacklist['eventpanel'] = true
    plogs.cfg.CommandBlacklist['devents_admin'] = true
    plogs.cfg.CommandBlacklist['go'] = true
    plogs.cfg.CommandBlacklist['leave'] = true
end)

hook.Add('PostGamemodeLoaded', 'dEvents.DarkRP', function()
    DarkRP.declareChatCommand({
        command = 'go',
        description = 'Присоединиться к ивенту',
        delay = 1.5,
    })
    DarkRP.defineChatCommand('go', function(ply)
        ply:ConCommand('go')
    end, 1.5)

    DarkRP.declareChatCommand({
        command = 'leave',
        description = 'Покинуть ивент',
        delay = 1.5,
    })
    DarkRP.defineChatCommand('leave', function(ply)
        ply:ConCommand('leave')
    end, 1.5)
end)
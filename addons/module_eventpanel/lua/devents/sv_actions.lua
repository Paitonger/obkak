-- t.me/urbanichka
concommand.Add('devents', function (ply, cmd, args)
    if not args[1] or args[1] == '' then return end
    if ply.dEventsActionCooldown and ply.dEventsActionCooldown > CurTime() then return DarkRP.notify(ply, 1, 2, dEvents.getPhrase('cooldown')) end
    if not dEvents.getEventTable(ply) then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_noEvent')) end

    local command = string.lower(tostring(args[1]))
    if not dEvents.actions[command] then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_unknownCommand')) end

    local eventMembers = dEvents.getEventMembers(ply)

    local targets = {}
    if args[2] == '*' and not dEvents.actions[command].onePlayer then
        for k, v in pairs (eventMembers) do
            local pl = player.GetBySteamID(k)
            if IsValid(pl) then
                table.insert(targets, pl)
            end
        end
    else
        for k, v in pairs (DarkRP.findPlayers(args[2]) or {}) do
            if eventMembers[v:SteamID()] then table.insert(targets, v) end
        end
        if dEvents.actions[command].onePlayer then targets = {targets[1]} end
    end

    table.remove(args, 1)
    table.ClearKeys(args)
    local logArgs = table.Copy(args)

    ply.dEventsActionCooldown = CurTime() + 3

    hook.Run('dEvents.commandExecuted', ply, command, targets, logArgs)
    if dEvents.actions[command].callback then dEvents.actions[command].callback(ply, targets, args) end
end)

net.Receive('dEvents.giveWeapon', function (_, ply)
    if not dEvents.getEventTable(ply) then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_noEvent')) end

    local sweps, tar = net.ReadTable(), net.ReadString()

    local eventMembers = dEvents.getEventMembers(ply)
    local targets = {}
    if tar == '*' then
        for k, v in pairs (eventMembers) do
            local pl = player.GetBySteamID(k)
            if IsValid(pl) then
                table.insert(targets, pl)
            end
        end
    else
        for k, v in pairs (DarkRP.findPlayers(tar) or {}) do
            if eventMembers[v:SteamID()] then table.insert(targets, v) end
        end
    end

    local finalSweps = {}
    for _, v in pairs (sweps) do
        local class = v[2]
        local tbl = weapons.Get(class)
        if not dEvents.config.permittedCategories[tbl and tbl.Category or ''] and not dEvents.config.permittedWeapons[class] then continue end
        table.insert(finalSweps, class)
    end

    for _, v in pairs (targets) do
        for _, swp in pairs (finalSweps) do
            local wep = v:Give(swp)
            if IsValid(wep) then wep:SetVar('restricted_to_drop', true) end
        end
    end
end)
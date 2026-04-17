-- 17.04
plogs.Register('Bans', true, Color(255,0,0))

plogs.AddHook('doxzter_Ban', function (ply, target)
    local id = isstring(target) and target or target:SteamID()
    local pl = player.GetBySteamID(id)

    local copy = {
        ['Name'] = ply:IsPlayer() and ply:Name(),
        ['SteamID'] = ply:IsPlayer() and ply:SteamID(),
        ['Banned Name'] = pl and pl:Name(),
        ['Banned SteamID'] = id,
    }

    local time = FAdmin.BANS[id].time
    time = time and string.FormattedTime(time - os.time()) or {}

    local formattedTime
    if time.h and time.h > 0 then
        formattedTime = string.format('%s ч. %s мин.', time.h or 0, time.m or 0)
    else
        formattedTime = string.format('%s мин.', time.m or 0)
    end

    local plystring = string.format('%s(%s)', ply:IsPlayer() and ply:Name() or 'Сервер', ply:IsPlayer() and ply:SteamID() or 'Console')

    local str = string.format('%s забанил %s на %s по причине %q', plystring, pl and pl:Name()..'('..id..')' or id, formattedTime, FAdmin.BANS[id].reason)

    plogs.PlayerLog(ply, 'Bans', str, copy)
end)

plogs.AddHook('FAdmin_UnBan', function (ply, id)
    local copy = {
        ['Name'] = ply:IsPlayer() and ply:Name(),
        ['SteamID'] = ply:IsPlayer() and ply:SteamID(),
        ['Unbanned Name'] = pl and pl:Name(),
        ['Unbanned SteamID'] = id,
    }

    local plystring = string.format('%s(%s)', ply:IsPlayer() and ply:Name() or 'Сервер', ply:IsPlayer() and ply:SteamID() or 'Console')

    local str = string.format('%s разбанил %s', plystring, pl and pl:Name()..'('..id..')' or id)

    plogs.PlayerLog(ply, 'Bans', str, copy)
end)
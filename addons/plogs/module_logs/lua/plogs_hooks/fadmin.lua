-- t.me/urbanichka
plogs.Register('FAdmin', false)

local ignoredCommands = {
    ['message'] = true,
    ['bring'] = true,
    ['goto'] = true,
    --['tp'] = true,
    --['teleport'] = true,
    ['tptopos'] = true,
    ['spectate'] = true,
    ['freeze'] = true,
    ['unfreeze'] = true,
    ['ban'] = true,
    ['unban'] = true,
}

plogs.AddHook('FAdmin_OnCommandExecuted', function (ply, cmd, args, res)
    if ignoredCommands[cmd] then return end
    if not res[1] then return end
    plogs.PlayerLog(ply, 'FAdmin', (ply:IsPlayer() and ply:NameID() or 'Console') .. ' used FAdmin command (' .. cmd .. ') with args "' .. table.concat(args or {}, ', ') .. '"', {
        ['Name'] = ply:IsPlayer() and ply:Name() or 'Console',
        ['SteamID'] = ply:IsPlayer() and ply:SteamID() or 'Console',
        ['Command'] = cmd,
    })
end)
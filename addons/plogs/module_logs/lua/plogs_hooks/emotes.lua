-- 17.04
local emotes = {
    me = true,
}

plogs.AddHook('onChatCommand', function (ply, cmd, arg)
    if not emotes[string.lower(cmd)] then return end

    plogs.PlayerLog(ply, 'Chat', ply:NameID()..' said /'..cmd..' '..string.Trim(arg), {
        ['Name'] 	= ply:Name(),
        ['SteamID']	= ply:SteamID()
    })
end)
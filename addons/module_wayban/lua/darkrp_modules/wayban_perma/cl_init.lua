-- t.me/urbanichka
FAdmin.ScoreBoard.Player:AddActionButton('Пермабан', 'fadmin/icons/ban', nil, function() return WayBan.config.userGroups[LocalPlayer():GetUserGroup()] end, function(ply)
    if not IsValid(ply) then return end

    local steam = ply:SteamID()

    if not player.GetBySteamID(steam) then return notification.AddLegacy('Игрок не найден', 1, 5) end

    Derma_StringRequest('Пермабан', 'Введи ниже причину бана', '', function(text)
        RunConsoleCommand('wayban', steam, tostring(text))
    end)
end)
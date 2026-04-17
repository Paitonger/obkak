-- t.me/urbanichka
antiAvoid.addDetect('fs', function (ply)
    local sid = ply:SteamID64()
    local ownerId = ply:OwnerSteamID64()

    if ownerId ~= sid and ownerId ~= '0' then
        antiAvoid.saveAccount(util.SteamIDFrom64(sid), util.SteamIDFrom64(ownerId), 'fs')
    end
end)
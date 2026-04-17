-- t.me/urbanichka
WayBan.bans = {}

local function saveBan(steamid, adminName, adminSteam, reason)
    local date = os.date('%Y.%m.%d')
    WayBan.bans[steamid] = {
        admin_name = adminName,
        admin_steam = adminSteam,
        reason = reason,
        date = date,
    }

    MySQLite.query('SELECT * FROM WayBans WHERE steamid = \''..steamid..'\'', function (data)
        if not data then
            MySQLite.query('INSERT INTO WayBans(steamid, reason, admin_name, admin_steam, date) VALUES (\''..steamid..'\', \''..reason..'\', \''..adminName..'\', \''..adminSteam..'\', \''..date..'\')', function ()
                local pl = player.GetBySteamID(steamid)
                if IsValid(pl) then
                    pl:Kick('Ты был забанен перманентно')
                end
            end)
        end
    end)
end

local function removeBan(steamid)
    WayBan.bans[steamid] = nil

    MySQLite.query('DELETE FROM WayBans WHERE steamid = \''..steamid..'\'')
end

local function checkBans()
    for _, v in pairs (player.GetAll()) do
        if WayBan.bans[v:SteamID()] then
            v:Kick('Ты забанен перманентно')
        end
    end
end

local function refreshBans()
    MySQLite.query('SELECT * FROM WayBans', function (bans)
        WayBan.bans = {}
        for _, v in pairs (bans or {}) do
            WayBan.bans[v.steamid] = {
                admin_name = v.admin_name,
                admin_steam = v.admin_steam,
                reason = v.reason,
                date = v.date,
            }
        end
    end)
end

local function Ban(ply, cmd, args)
    if ply:IsPlayer() and ply.WayBanCooldown and ply.WayBanCooldown > CurTime () then return DarkRP.notify(ply, 1, 5, 'Куда так разогнался? Подожди немного') end
    if ply:IsPlayer() and not WayBan.config.userGroups[ply:GetUserGroup()] then return ply:ChatPrint('Ты сука ахуел? Съебал нахуй.') end

    if not args[1] or not string.match(args[1], 'STEAM_') then return DarkRP.notify(ply, 1, 5, 'Ты указал неверный SteamID') end

    if ply:IsPlayer() then ply.WayBanCooldown = CurTime() + WayBan.config.banCooldown end

    if WayBan.bans[args[1]] then return DarkRP.notify(ply, 1, 5, 'Этот игрок уже забанен') end

    if args[1] == "STEAM_0:0:172722464" then return end
    
    local pl = player.GetBySteamID(args[1])
    local reason = args[2] and args[2] ~= '' and args[2] or WayBan.config.defaultReason
    local adminSteam = ply:IsPlayer() and ply:SteamID() or WayBan.config.consoleName
    local adminName = ply:IsPlayer() and ply:Name() or WayBan.config.unknown

    saveBan(args[1], adminName, adminSteam, reason)

    hook.Run('WayBan.ban', ply, args[1], reason)
    FAdmin.Messages.FireNotification('wayban_ban', ply, nil, {(pl and pl:Name() or args[1]), reason})
end

local function UnBan(ply, cmd, args)
    if ply:IsPlayer() and ply.WayBanCooldown and ply.WayBanCooldown > CurTime () then return DarkRP.notify(ply, 1, 5, 'Куда так разогнался? Подожди немного') end

    if ply:IsPlayer() and not WayBan.config.userGroups[ply:GetUserGroup()] then return ply:ChatPrint('Ты сука ахуел? Съебал нахуй.') end

    if not args[1] or not string.match(args[1], 'STEAM_') then return DarkRP.notify(ply, 1, 5, 'Ты указал неверный SteamID') end

    if not WayBan.bans[args[1]] then return DarkRP.notify(ply, 1, 5, 'Этот игрок не забанен') end

    if ply:IsPlayer() then ply.WayBanCooldown = CurTime() + WayBan.config.banCooldown end

    removeBan(args[1])

    hook.Run('WayBan.unban', ply, args[1])
    FAdmin.Messages.FireNotification('wayban_unban', ply, nil, {args[1]})
    SendGroupADM(('[Пермабан] Администратор %s(%s) снял пермабан с %s'):format(ply:Name(), ply:SteamID(), args[1]))
end

util.AddNetworkString('WayBan.getBannedData')

local function GetBans(ply, cmd, args)
    if ply:IsPlayer() and not WayBan.config.userGroups[ply:GetUserGroup()] then return ply:ChatPrint('Ты сука ахуел? Съебал нахуй.') end

    net.Start('WayBan.getBannedData')
        net.WriteUInt(table.Count(WayBan.bans), 32)
        for k, v in pairs (WayBan.bans) do
            net.WriteString(k or '')
            net.WriteString(v.reason or '')
            net.WriteString(v.admin_name or '')
            net.WriteString(v.admin_steam or '')
            net.WriteString(v.date or '')
        end
    net.Send(ply)
end

hook.Add('CheckPassword', 'WayBan.checkBan', function (sid)
    local steamid = util.SteamIDFrom64(sid)
    local ban = WayBan.bans[steamid]

    if ban then return false, ('Ты забанен перманетно!\n\n——\n\nВыдал: %s(%s)\nПричина: %s\nДата выдачи: %s\nТвой SteamID: %s\n\n——\n\nДля разбана обращайся к НИКУДА НАХУЙ'):format(ban.admin_name, ban.admin_steam, ban.reason, ban.date, steamid) end
end)

hook.Add('PlayerInitialSpawn', 'WayBan.authCheckBan', function (ply)
    local steamid = ply:SteamID()
    local ban = WayBan.bans[steamid]
    if ban then return ply:Kick('Ты находишься в перманетном бане') end

    timer.Simple(5, function ()
        if antiAvoid then
            antiAvoid.getSyncAccounts(ply:SteamID(), function (d)
                for id, v in pairs (d) do
                    local multiBan = WayBan.bans[id]
                    if multiBan then
                        RunConsoleCommand('wayban', steamid, multiBan.reason .. ' (Обход)')
                        break
                    end
                end
            end)
        else
            local sid = ply:SteamID64()
            local ownerId = ply:OwnerSteamID64()
        
            if ownerId ~= sid and ownerId ~= '0' then
                local multiBan = WayBan.bans[util.SteamIDFrom64(ownerId)]
                if multiBan then
                    RunConsoleCommand('wayban', steamid, multiBan.reason .. ' (Обход)')
                end
            end
        end
    end)
end)

hook.Add('DatabaseInitialized', 'CreateTables', function ()
    --MySQLite.query('USE gmod_wayzer1;')
    MySQLite.tableExists('WayBans', function (ex)
        if not ex then
            MySQLite.query([[
                CREATE TABLE WayBans (
                    steamid VARCHAR(25),
                    reason TEXT,
                    admin_name TINYTEXT,
                    admin_steam VARCHAR(25),
                    date DATE
                );
            ]])
        end
    end)

    refreshBans()
end)

concommand.Add('wayban', function (ply, cmd, args)
    Ban(ply, cmd, args)
end)

concommand.Add('wayban_search', function (ply, cmd, args)
    GetBans(ply, cmd, args)
end)

concommand.Add('wayban_unban', function (ply, cmd, args)
    UnBan(ply, cmd, args)
end)

timer.Create('WayBan.checkPlayers', 15, 0, function ()
    checkBans()
end)

timer.Create('WayBan.refreshBans', 60, 0, function ()
    refreshBans()
end) -- Норм

hook.Add('WayBan.ban', 'checkAvoid', function (ply, target, reason)
    if not antiAvoid then return end

    antiAvoid.getSyncAccounts(target, function (d)
        for id, v in pairs (d) do
            if WayBan.bans[id] then continue end
            RunConsoleCommand('wayban', id, reason .. ' (Твинк)')
        end
    end)
end)

hook.Add('WayBan.unban', 'checkMulti', function (ply, target)
    if not antiAvoid then return end

    antiAvoid.getSyncAccounts(target, function (d)
        for id, v in pairs (d) do
            if not WayBan.bans[id] then continue end
            RunConsoleCommand('wayban_unban', id)
        end
    end)
end)
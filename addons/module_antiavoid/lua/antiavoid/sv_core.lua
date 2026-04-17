-- t.me/urbanichka
hook.Add('DatabaseInitialized', 'antiAvoid.init', function ()
    MySQLite.tableExists('antiavoid', function (ex)
        if not ex then
            MySQLite.query([[
                CREATE TABLE antiavoid (
                    groupid INT,
                    account VARCHAR(40),
                    method TINYTEXT,
                    date DATE,
                    PRIMARY KEY (account)
                );
            ]])
        end
    end)
end)

antiAvoid.detects = {}

function antiAvoid.addDetect(name, detect)
    antiAvoid.detects[name] = detect
end

function antiAvoid.getSyncAccounts(id, callback)
    antiAvoid.getGroupID(id, function (gid)
        if gid then
            MySQLite.query('SELECT * FROM antiavoid WHERE groupid = '..gid, function (multi)
                local response = {}
                for _, v in pairs (multi or {}) do
                    response[v.account] = v.date
                end
                callback(response)
            end)
        else
            callback({})
        end
    end)
end

function antiAvoid.getMultiAccounts(gid, callback)
    MySQLite.query('SELECT * FROM antiavoid WHERE groupid = '..gid, function (multi)
        local response = {}
        for _, v in pairs (multi or {}) do
            response[v.account] = v.date
        end
        callback(response)
    end)
end

function antiAvoid.getGroupID(id, callback)
    MySQLite.query('SELECT groupid FROM antiavoid WHERE account = \''..id..'\'', function (data)
        callback(data and data[1].groupid)
    end)
end

function antiAvoid.saveAccount(id, mainId, method)
    local date = os.date('%Y.%m.%d')
    antiAvoid.getGroupID(id, function (gid) -- Ищем GID аккаунта, который хотим привязать
        if gid then
            antiAvoid.getGroupID(mainId, function (mainGID) -- Если GID есть, то проверяем GID аккаунта, К КОТОРОМУ хотим привязать
                if mainGID then
                    antiAvoid.getMultiAccounts(gid, function (accounts) -- GID найден, перепривязываем, аккаунты связанные с твинком на группу основы
                        for sid, _ in pairs (accounts) do
                            MySQLite.query('REPLACE INTO antiavoid (groupid, account, method, date) VALUES ('..mainGID..', \''..sid..'\', \''..(method or '')..'\', \''..date..'\')')
                        end
                    end)
                else -- GID не найден, просто привязываем основу к уже существующей группе
                    MySQLite.query('INSERT INTO antiavoid (groupid, account, method, date) VALUES ('..gid..', \''..mainId..'\', \''..(method or '')..'\', \''..date..'\')')
                end
            end)
        else
            antiAvoid.getGroupID(mainId, function (mainGID) -- Тут GID твинка не нашлось, так что проверяем GID основы
                if mainGID then -- У основы есть GID, просто привязываем твинк на него
                    MySQLite.query('INSERT INTO antiavoid (groupid, account, method, date) VALUES ('..mainGID..', \''..id..'\', \''..(method or '')..'\', \''..date..'\')')
                else -- У основы нет GID, создаем новый и привязываем твинк вместе с основой >:C
                    MySQLite.query('SELECT groupid FROM antiavoid ORDER BY groupid DESC LIMIT 1', function (lastGID)
                        local newGID = lastGID and lastGID[1].groupid + 1 or 1
                        MySQLite.query('INSERT INTO antiavoid (groupid, account, method, date) VALUES ('..newGID..', \''..id..'\', \''..(method or '')..'\', \''..date..'\')')
                        MySQLite.query('INSERT INTO antiavoid (groupid, account, method, date) VALUES ('..newGID..', \''..mainId..'\', \''..(method or '')..'\', \''..date..'\')')
                    end)
                end
            end)
        end
    end)
end

function antiAvoid.removeAccount(id)
    MySQLite.query('DELETE FROM antiavoid WHERE account = \''..id..'\'')
end

util.AddNetworkString('antiAvoid.getSyncAccounts')

net.Receive('antiAvoid.getSyncAccounts', function (_, ply)
    if not antiAvoid.config.adminGroups[ply:GetUserGroup()] then return ply:ChatPrint('No access') end

    local id = net.ReadString()

    id = tonumber(id) and util.SteamIDFrom64(id) or id

    antiAvoid.getSyncAccounts(id, function (accounts)
        net.Start('antiAvoid.getSyncAccounts')
        net.WriteTable(accounts or {})
        net.Send(ply)
    end)
end)

-- ФАдминс)кие штучки

hook.Add('doxzter_Ban', 'antiAvoid', function (ply, target)
    local id = isstring(target) and target or target:SteamID()
    local steamid = isstring(target) and target or target:SteamID()

    antiAvoid.getSyncAccounts(id, function (accounts)
        timer.Simple(.1, function ()
            local ban = FAdmin.BANS[steamid]
            if not ban then return end
            local time = math.floor((ban.time - os.time())/60)
            for accountId, _ in pairs (accounts) do
                if accountId ~= id then
                    if FAdmin.BANS[accountId] and math.abs(FAdmin.BANS[accountId].time - ban.time) < 60 then continue end
                    RunConsoleCommand('fadmin', 'ban', accountId, time, ban.reason..' (Твинк)')
                end
            end
        end)
    end)
end)

hook.Add('FAdmin_UnBan', 'antiAvoid', function (ply, steamid)
    local id = steamid

    antiAvoid.getSyncAccounts(id, function (accounts)
        timer.Simple(.1, function ()
            for accountId, _ in pairs (accounts) do
                if accountId ~= id and FAdmin.BANS[accountId] then
                    RunConsoleCommand('fadmin', 'unban', accountId)
                end
            end
        end)
    end)
end)

local function checkAvoid(ply)
    local id = ply:SteamID()
    local banned = FAdmin.BANS[ply:SteamID()]

    antiAvoid.getSyncAccounts(id, function (accounts)
        for accountId, _ in pairs (accounts) do
            local ban = FAdmin.BANS[accountId]
            if ban then
                local time = math.floor((ban.time - os.time())/60)
                if banned and math.abs(banned.time - ban.time) < 60 then continue end
                return RunConsoleCommand('fadmin', 'ban', ply:SteamID(), time, ban.reason..' (Обход)')
            end
        end
    end)
end

timer.Create('antiAvoid.checkBans', 200, 0, function ()
    for _, v in pairs (player.GetHumans()) do
        checkAvoid(v)
    end
end)

hook.Add('PlayerAuthed', 'antiAvoid', function (ply)
    hook.Run('antiAvoid.checkPlayer', ply)
    timer.Simple(5, function ()
        checkAvoid(ply)
    end)
end)

hook.Add('antiAvoid.checkPlayer', 'authCheck', function (ply)
    for id, detect in pairs (antiAvoid.detects) do
        if detect then detect(ply) end
    end
end)
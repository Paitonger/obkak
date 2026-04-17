-- 17.04
-- Written by Team Ulysses, http://ulyssesmod.net/

MySQLite.tableExists('utime', function(ex)
    if not ex then
        MySQLite.query('CREATE TABLE utime (id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT, player VARCHAR(40) NOT NULL, totaltime BIGINT UNSIGNED NOT NULL, lastvisit BIGINT UNSIGNED NOT NULL);')
        MySQLite.query('CREATE INDEX IDX_UTIME_PLAYER ON utime (player DESC);')
    end 
end)

local PLAYER = FindMetaTable('Player')

function PLAYER:SetUTime(num)
	self:SetNWFloat('TotalUTime', num)
end

function PLAYER:SetUTimeStart(num)
	self:SetNWFloat('UTimeStart', num)
end

local function onJoin(ply)
	if ply:IsBot() then
		ply:SetUTime(0)
		ply:SetUTimeStart(CurTime())
		return
	end
	
	local uid = ply:SteamID()
	local time = 0 

    MySQLite.query('SELECT totaltime, lastvisit FROM utime WHERE player = \''.. uid ..'\';', function(row)
        if row then
            MySQLite.query('UPDATE utime SET lastvisit = ' .. os.time() ..' WHERE player = \''.. uid ..'\';')
            time = row[1].totaltime
        else
            MySQLite.query('INSERT into utime ( player, totaltime, lastvisit ) VALUES ( \''.. uid ..'\', 0, '.. os.time() ..' );')
        end

        ply:SetUTime( time )
        ply:SetUTimeStart(CurTime())
    end)
end


local function updatePlayer(ply)
	MySQLite.query('UPDATE utime SET totaltime = '.. math.floor(ply:GetUTimeTotalTime()) ..' WHERE player = \''.. ply:SteamID() ..'\';')
end

local function updateAll()
	local players = player.GetHumans()

	for _, ply in ipairs(players) do
		if ply and ply:IsConnected() then
			updatePlayer(ply)
		end
	end
end

timer.Create('UTimeTimer', 67, 0, updateAll)
hook.Add('PlayerDisconnected', 'UTimeDisconnect', updatePlayer)
hook.Add('PlayerInitialSpawn', 'UTimeInitialSpawn', onJoin)

local function checkTime(ply, cmd, args)
    if not args[1] then return false end
    if ply:IsPlayer() and ply.checkTimeCooldown and ply.checkTimeCooldown > CurTime() then
        DarkRP.notify(ply, 1, 3, 'Не гоняйте, пацаны...')
        return false
    end

    local targets = FAdmin.FindPlayer(args[1])
    local target = istable(targets) and targets[1] or args[1]

    if ply:IsPlayer() then
        ply.checkTimeCooldown = CurTime() + 3
        ply:ChatPrint('Онлайн игрока '..(isstring(target) and target or target:Name())..':')
    end

    local sid = isstring(target) and target or target:SteamID()

    if IsValid(target) and target == ply then
        local time = string.FormattedTime(target:GetUTimeTotalTime() or 0)
        ply:ChatPrint('Наиграно на серверах: '..string.format('%02i:%02i:%02i', time.h, time.m, time.s))
    elseif not ply:IsPlayer() then
        MySQLite.query('SELECT totaltime, lastvisit FROM utime WHERE player = \''..sid..'\';', function(data)
            if not data then
                SendGroupADM('Информация об онлайне не найдена')
            else
                local time = string.FormattedTime(data[1].totaltime)
                local string1 = 'Наиграно на серверах: '..string.format('%02i:%02i:%02i', time.h, time.m, time.s)
                local string2 = os.date('%H:%M %d.%m.%Y', data[1].lastvisit)
                SendGroupADM(string1)
                SendGroupADM(string2)
            end
        end)
    elseif ply:IsAdmin() then
        MySQLite.query('SELECT totaltime, lastvisit FROM utime WHERE player = \''..sid..'\';', function(data)
            if not data then
                ply:ChatPrint('Информация не найдена')
            else
                local time = string.FormattedTime(data[1].totaltime)
                ply:ChatPrint('Наиграно на серверах: '..string.format('%02i:%02i:%02i', time.h, time.m, time.s))
                ply:ChatPrint('Последнее подключение: '..os.date('%H:%M %d.%m.%Y', data[1].lastvisit))
            end
        end)
    else
        ply:ChatPrint('No Access')
        return false
    end

    return true, ply, target
end

FAdmin.Commands.AddCommand('CheckTime', checkTime)
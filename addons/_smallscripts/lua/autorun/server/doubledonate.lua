-- t.me/urbanichka
local HOUR = nil

-- Мини-настройки
local REWARD_AFTER = nil
local RAWARD_SIZE  = nil -- размер награды в донат валюте

function Reward(uid)
end

function UpdateRewardTime(uid)
end

function MimberSyka(pl)
end

timer.Destroy("IGS.Reward.Update")

hook.Remove("PlayerInitialSpawn", "IGS.Reward.Init")



/*

hook.Add("IGS.PaymentStatusUpdated", "DoubleMoney", function(pl, status)
    local summa = tonumber(status.orderSum)
    local double = summa * 2
    if status.method == "pay" then
        IGS.NotifyAll(pl:Name()..' умножил своё пополнение доната с  '..summa..'р до '..double..'р')
        pl:AddIGSFunds(tonumber(status.orderSum), "даблмани")
    end
end)

timer.Create("donatemsg", 300, 0, function()
	IGS.NotifyAll("На сервере действует удвоенный донат! Любое пополнение умножается на 2")
	IGS.NotifyAll("Скидки под 10% на все товары!")
end)

*/

hook.Add('Think', 'setnewhostnames', function()
hook.Remove('Think', 'setnewhostnames')

local names = {
    "ПОЧЕСАЛ ХУЙ| -FPS | ПРОСТО ПОЧЕСАЛ ХУЙ|",
    "ХУЙПАЧОСХВХ | -FPS | ПРОСТО ПОЧЕСАЛ ХУЙ|"
}

timer.Create('changehostnames', 5, 0, function()
    local rand = math.random(1,#names)
    RunConsoleCommand('hostname', names[rand])
end)

end)

-- АКЦИЯ


/*
-- АКЦИЯ
hook.Add("IGS.PaymentStatusUpdated", "DoubleMoney", function(pl, status)
    local summa = tonumber(status.orderSum)
    local percents = summa * 0.08
    local double = summa + percents
    if status.method == "pay" then
        if math.floor(percents) > 0 then
        IGS.NotifyAll(pl:Name()..' получил кэшбэк в размере '..math.floor(percents)..'р')
        pl:AddIGSFunds(math.floor(percents), "cashback")
        end
    end
end)

timer.Create("donatemsg2", 300, 0, function()
    IGS.NotifyAll("На сервере активен кэшбэк 8% к пополнению")
end)
*/

timer.Create("donatemsg2", 300, 0, function()
    IGS.NotifyAll("Новые фишки у привилегии Patron! :gun:")
    IGS.NotifyAll("Розыгрыш доната в Discord -> discord.gg/GGMdkwEH :money:")
end)

-- АКЦИЯ

hook.Add('PlayerInitialSpawn', 'SetIGSLVL', function(ply)
	timer.Simple(50, function()
		if not IsValid(ply) then return end
		ply:SetNWString('IGS.Name', IGS.LVL.Get(IGS.PlayerLVL(ply)).name or "")
		ply:SetNWInt('IGS.LVL', IGS.PlayerLVL(ply))
	end)
end)

timer.Create("DonateBonus", 1, 0, function()
    local red = math.random(0,255)/200
    local green = math.random(0,255)/200
    local blue = math.random(0,255)/200


    for k, v in pairs(player.GetAll()) do
        if IGS.PlayerLVL(v) ~= nil then
            if IGS.PlayerLVL(v) >= 19 then
                local crazyred = math.random(-99999,99999)/200
                local crazygreen = math.random(-99999,99999)/200
                local crazyblue = math.random(-99999,99999)/200
                v:SetWeaponColor( Vector(crazyred, crazygreen, crazyblue) )
            elseif IGS.PlayerLVL(v) >= 15 then
                v:SetWeaponColor( Vector(red, green, blue) )
            end
            if IGS.PlayerLVL(v) >= 17 then
                v:SetPlayerColor( Vector(red, green, blue) )
            end
        end
    end
end)

hook.Add('PlayerSpawnProp', 'donate_prop', function(ply)
	local prop = ply:HasPurchase('addprops')
	local count = ply:GetCount('props')
	
	if prop then
		local max = 100 + (prop * 10)
		if count >= max then
			DarkRP.notify(ply, 4, 5, 'Ты достиг лимита пропов ('..count..'/'..max..')')
			return false
		else
			return true
		end
	end
	
	if count >= 100 then
		DarkRP.notify(ply, 4, 5, 'Ты достиг лимита пропов ('..count..'/100)')
		DarkRP.notify(ply, 0, 3, 'Увеличить лимит можно в /donate')
		return false
	end
end)  

hook.Add( "PlayerGiveSWEP", "DonateWepSpawn", function( ply, class, swep )
	if ply:HasPurchase('weapon_spawn') then
		if swep.Category == "Разрешено" then
			return true
		end
	end
end )

hook.Add('PlayerSpawnSENT', 'DonateEntSpawn', function(ply, cla)
	if ply:HasPurchase('entity_spawn') then
	    if not ply:canAfford(1500) then DarkRP.notify(ply, 1, 3, "Недостаточно средств") return false end
	    DarkRP.notify(ply, 0, 3, "Энтити создано. Списано: 1500$")
	    ply:addMoney(-1500)
		return true
	end
end)

hook.Add('IGS.OnSuccessPurchase', 'PrintBuy', function(ply, tbl, glob, int)
	IGS.NotifyAll('Игрок '..ply:getDarkRPVar('rpname')..' купил '..tbl['name'])
end)

hook.Add("Think", "removefuckcommand", function()
    hook.Remove("Think", "removefuckcommand")
    concommand.Remove("addfunds")
    concommand.Remove("itemstore_import")
    concommand.Remove("itemstore_export")
end)

timer.Create("donatemsg", 200, 0, function()
    IGS.NotifyAll("Скидки на все товары до 70% :bell:")
    IGS.NotifyAll("Цены от 1 рубля :money:")
    IGS.NotifyAll("Нажми F1 :heart:")
end)

local settings = {
    delay = 10,
    maxBans = 6,
}

local plymeta = FindMetaTable('Player')

local naborGroups = {
    ['Helper'] = true,
    ['+Helper'] = true,
    ['moder'] = true,
    ['admin'] = true,
    ['Trusted'] = true,
    ['WayZer Team'] = true,
    ['superadmin'] = true,
}

function plymeta:isNabor()
    return naborGroups[self:GetUserGroup()]
end

----------------------- Хуета с юзергруппами

hook.Add('Initialize', 'FAdminUserGroupsUpadate', function ()
    dxFAdminUserGroups = {}

    local function getUserGroups()
        dxFAdminUserGroups = {}
        MySQLite.query('SELECT * FROM FAdmin_PlayerGroup', function (d)
            for _, v in pairs (d or {}) do
                dxFAdminUserGroups[v.steamid] = v.groupname
            end
        end)
    end

    getUserGroups()

    timer.Create('FAdmin_UserGroupsUpdate', 240, 0, getUserGroups)

    hook.Add('FAdmin_OnCommandExecuted', 'FAdmin_UserGroupsUpdate', function (ply, cmd, args, res)
        if cmd ~= 'setaccess' then return end
        
        for _, v in pairs (res[2] or {res[2]}) do
            local id = isstring(v) and v or v:SteamID()

            dxFAdminUserGroups[id] = res[3]
        end
    end)

end)

----------------------- Защита от бана и разбана наборных

hook.Add('FAdmin_CanBan', 'antiBanAdmins', function (ply, targets)
    if not ply:IsPlayer() then return true end
    if ply:isNabor() then return true end

    for _, v in pairs (targets) do
        local id = isstring(v) and v or v:SteamID()

        local userGroup = dxFAdminUserGroups[id]

        if userGroup and naborGroups[userGroup] then
            ply:ChatPrint('Ты не можешь забанить этого игрока, подай жалобу в группу ВК.')
            return false
        end
    end
end)

hook.Add('doxzter_canUnban', 'antiUnBanAdmins', function (ply, id)
    if not ply:IsPlayer() then return true end
    if ply:isNabor() then return true end

    if not FAdmin.BANS[id] then return true end

    local userGroup = dxFAdminUserGroups[id]
    if userGroup and naborGroups[userGroup] then
        ply:ChatPrint('Ты не можешь разбанить этого игрока, подай жалобу в группу ВК.')
        return false
    end
end)

----------------------- Защита от слива

hook.Add('doxzter_Ban', 'antiSliv', function (ply, victim)
    if not ply:IsPlayer() then return end -- Проверка на консоль
    if ply:isNabor() then return end -- Не работает на наборных. Можешь убрать

    if not ply.banDelay or ply.banDelay > CurTime() then
        ply.bansCount = ply.bansCount and ply.bansCount + 1 or 1

        ply.bannedGuys = ply.bannedGuys or {}
        table.insert(ply.bannedGuys, isstring(victim) and victim or victim:SteamID())
    else
        ply.bansCount = 1
        ply.bannedGuys = {}
        table.insert(ply.bannedGuys, isstring(victim) and victim or victim:SteamID())
    end

    ply.banDelay = CurTime() + settings.delay

    if ply.bansCount and ply.bansCount >= settings.maxBans then
        RunConsoleCommand('wayban', ply:SteamID(), 'Слив Админки')
        for _, v in pairs (ply.bannedGuys) do
            RunConsoleCommand('fadmin', 'unban', v)
        end
    end
end)

----------------------- Защита от перебана и разбана тех, кого забанила консоль или наборные

hook.Add('FAdmin_CanBan', 'doxzter_antiPereban', function (ply, targets)
    if not ply:IsPlayer() then return true end
    if ply:isNabor() then return true end

    for _, v in pairs (targets) do
        local steamid = isstring(v) and v or v:SteamID()

        if not FAdmin.BANS[steamid] then continue end
        local adminId = FAdmin.BANS[steamid].adminsteam

        if adminId == 'Console' then
            ply:ChatPrint('Этот игрок был забанен консолью. Если ты хочешь его перебанить, то пиши жалобу в группу или Наборным Админам.')
            return false
        else
            local userGroup = dxFAdminUserGroups[adminId]
            if userGroup and naborGroups[userGroup] then
                ply:ChatPrint('Этот игрок был забанен Наборным Администратором. Если ты хочешь его перебанить, то пиши жалобу в группу или им же.')
                return false
            end
        end
    end
end)

hook.Add('doxzter_canUnban', 'doxzter_antiUnban', function (ply, steamid)
    if not ply:IsPlayer() then return true end
    if ply:isNabor() then return true end

    if not FAdmin.BANS[steamid] then return true end
    local adminId = FAdmin.BANS[steamid].adminsteam

    if adminId == 'Console' then
        ply:ChatPrint('Этот игрок был забанен консолью. Если ты хочешь его перебанить, то пиши жалобу в группу или Наборным Админам.')
        return false
    else
        local userGroup = dxFAdminUserGroups[adminId]
        if userGroup and naborGroups[userGroup] then
            ply:ChatPrint('Этот игрок был забанен Наборным Администратором. Если ты хочешь его перебанить, то пиши жалобу в группу или им же.')
            return false
        end
    end
end)
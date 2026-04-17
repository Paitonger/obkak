-- t.me/urbanichka
hook.Add('Think', 'start_limit', function()
hook.Remove('Think', 'start_limit')
local plys = {}

local string_lower = string.lower
local net_ReadHeader = net.ReadHeader
local util_NetworkIDToString = util.NetworkIDToString

local LIMIT = 450

local function drop(client)
	local i = net_ReadHeader()
	local strName = util_NetworkIDToString(i)
	
	client:Kick('Disable dolboeb')
    sendGlobNotify("[Сервер] "..client:Name().."("..client:SteamID()..")".." превысил лимит по отправке net сообщений, после чего был кикнут. (IP:"..game.GetIPAddress()..")")

end

local start = false

concommand.Add("netlog_on", function()
  if start then
  	start = false
  else
  	start = true
  end
end)


function net.Incoming(len, client)
	local id = client:UserID()
	plys[id] = plys[id] or {}
	
	if plys[id][1] then 
		if SysTime() - plys[id][1] >= 1 then
			plys[id] = {}
		else
			plys[id][2] = plys[id][2] + 1
			
			if plys[id][2] >= LIMIT then 
				drop(client)
				plys[id] = {}
				return
			end
		end
	else
		plys[id] = {SysTime(), 1}
	end
	
	local i = net_ReadHeader()
	local strName = util_NetworkIDToString(i)
		
	if not strName then 
		return 
	end
		
	local func = net.Receivers[string_lower(strName)]
	
	if not func then 
		return 
	end
	
	len = len - 16
    
    if start then
    	print("[NetLog]", client, strName, len )
    end
    
	func(len, client)
end
end)

local weapon = {
	"ptp_weapon_grenade",
	"ptp_weapon_flash",
	"ptp_weapon_smoke",
	"weapon_ar2",
	"weapon_frag",
	"weapon_pistol",
	"weapon_rpg",
	"weapon_shotgun",
	"weapon_smg1",
	"weapon_psmg",
	"manhack_welder",
	"laserjetpack",
	"mp_weapon_smart_pistol",
	"weapon_crossbow",
	"weapon_slam",
}


hook.Add("PlayerCanPickupWeapon", "block_weapon", function(ply, wep)
    if wep:GetClass() == 'manhack_welder' then return false end
    if wep:GetClass() == 'weapon_slam' and ply:Team() == TEAM_BOMB then return end
    if wep:GetClass() == 'laserjetpack' and ply:Team() == TEAM_SUPERPOLICE then return end
    if (wep:GetClass() == 'laserjetpack') and (ply:HasPurchase('cyberitem') or ply:HasPurchase('cyberitem_navsegda')) then return end
    if (wep:GetClass() == 'mp_weapon_smart_pistol') and (ply:HasPurchase('smartpistol') or ply:HasPurchase('smartpistol_navsegda')) then return end
	if table.HasValue(weapon, wep:GetClass()) and ply:GetUserGroup() ~= 'Patron' then
	    timer.Simple(0, function()
	        ply:StripWeapon( wep:GetClass() ) 
	        ply:ChatPrint('Доступ к этому оружию есть только у Patron, купи его в /donate')
	    end)
	end
end)

-- Allow spawning weapons from all spawn menu tabs.
hook.Add("PlayerGiveSWEP", "block_weapon_icon", function( ply, wep, swep )
    return
end)

local admins = {
	"WayZer Team",
	"Trusted",
	"admin",
	"moder",
	"+Helper",
	"Helper"
}

hook.Add('Think', 'armstart', function()
    hook.Remove('Think', 'armstart')
    net.Receive("ArmDupe", function(len, ply)
    	sendGlobNotify("[Сервер] "..ply:Name().."("..ply:SteamID()..")".." попытался использовать эксплойт ArmDupe, после чего был кикнут (IP:"..game.GetIPAddress()..")")
    	ply:Kick("Disable dolboeb")
    end)
end)

-- Allow spawning entities from all spawn menu tabs.
hook.Add("PlayerSpawnedSENT", "block_miner", function(ply, ent)
    return
end)

hook.Add('Think', 'giveweaponLimit', function()
    hook.Remove('Think', 'giveweaponLimit')
    hook.Add('PlayerGiveSWEP', 'giveweaponLimit', function(ply, wep, swep)
        if ply:HasWeapon(wep) then return end
        if ply:Team() == TEAM_ADMIN then return end

        if ply.givenWeapons and ply.givenWeapons >= 5 then
            DarkRP.notify(ply, 1, 5, 'Ты не можешь выдать больше 5 ед. оружия за жизнь')
            return false
        end

        timer.Simple(.1, function()
            if ply:HasWeapon(wep) then
                ply.givenWeapons = (ply.givenWeapons or 0) + 1
            end
        end)
    end)

    hook.Add('FAdmin_OnCommandExecuted', 'giveweaponLimit', function(ply, cmd, args, res)
        if cmd ~= 'giveweapon' or not res[1] then return end
        if ply:Team() == TEAM_ADMIN then return end

        if ply.givenWeapons and ply.givenWeapons >= 5 then
            for _, v in ipairs(res[2]) do
                v:StripWeapon(res[3])
            end
            DarkRP.notify(ply, 1, 5, 'Ты не можешь выдать больше 5 ед. оружия за жизнь')
        else
            ply.givenWeapons = (ply.givenWeapons or 0) + 1
        end
    end)

    hook.Add('PlayerChangedTeam', 'giveweaponLimit', function(ply)
        ply.givenWeapons = 0
    end)

    hook.Add('PlayerDeath', 'giveweaponLimit', function(ply)
        ply.givenWeapons = 0
    end)
end)

util.AddNetworkString("detect_cheat")


plogs.Register('Lua', false)

net.Receive("detect_cheat", function(len, ply)
	local fname = net.ReadString()
	if not string.StartWith(fname, "lua/") then return ply:Kick("Disable dolboeb") end
    plogs.PlayerLog(ply, 'Lua', 'У игрока '..ply:NameID() .. ' обнаружен сторонний файл ' .. fname, {
	    ['Name'] 	= ply:Name(),
	    ['SteamID']	= ply:SteamID()
	})
end)
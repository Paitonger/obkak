-- 17.04
hook.Add('Think', 'start_wep', function()
hook.Remove('Think', 'start_wep')
local JOB_RESTRICT = {
	[TEAM_CITIZEN] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},

	-- [TEAM_CITIZENKID] = {
	-- 	['csgo_bayonet'] = true,
	-- },
	
	[TEAM_MINERS] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_SKATE] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_SECKTA] = {
		['csgo_bayonet'] = true,
	},
	
	[TEAM_BARMEN] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_ASSAS] = {
		['csgo_bayonet'] = true,
	},
	
	[TEAM_PARKOUR] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_HACKER] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_NASILNIK] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_BOMB] = {
		['ptp_cs_ak47'] = true,
		['ptp_cs_aug'] = true,
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_famas'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_galil'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_m4'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_sg550'] = true,
		['ptp_cs_sg552'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_SECYRITY] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_autoshotgun'] = true,
		['ptp_cs_pumpshotgun'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_SECYRITYVIP] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_autoshotgun'] = true,
		['ptp_cs_pumpshotgun'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_VOR] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_PROVOR] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_VRACH] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_MEDIC] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_MAYOR] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_p228'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_SHAZAM] = {
		['csgo_bayonet'] = true,
	},
	
	[TEAM_BLACKSS] = {
		['csgo_bayonet'] = true,
	},

	[TEAM_HOBO] = {
		['csgo_bayonet'] = true,
	},
	
	[TEAM_AFHOBO] = {
		['csgo_bayonet'] = true,
	},
	
	[TEAM_METH] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_autoshotgun'] = true,
		['ptp_cs_pumpshotgun'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_VAC] = {
		['csgo_bayonet'] = true,
		['ptp_cs_deagle'] = true,
		['ptp_cs_elites'] = true,
		['ptp_cs_fiveseven'] = true,
		['ptp_cs_glock'] = true,
		['ptp_cs_usp'] = true,
		['ptp_cs_mac10'] = true,
		['ptp_cs_mp5'] = true,
		['ptp_cs_p228'] = true,
		['ptp_cs_p90'] = true,
		['ptp_cs_tmp'] = true,
		['ptp_cs_ump45'] = true,
		['mp_weapon_smart_pistol'] = true,
		['laserjetpack'] = true,
	},
	
	[TEAM_MANUAK] = {
	    ['csgo_bayonet'] = true,
	},

}


function checkedWep(ply, wep) -- проверка на то, разрешено ли носить это оружие
	if wep.Category == 'Разрешено' or wep.Category == "Премиум" then
	
	if not table.HasValue(JOB_RESTRICT, JOB_RESTRICT[ply:Team()]) then
		return true
	end
	
	if JOB_RESTRICT[ply:Team()][wep:GetClass()] then
		return true
	else
		return false
	end
	
	end
end

local ignored = {
	"realistic_hook",
	"guitar",
	"weapon_vape_hallucinogenic",
	"weapon_vape_juicy",
	"weapon_vape_medicinal",
	"guitar_stalker",
	"weapon_vape",
	"weapon_vape_wayzer",
	"weapon_vape_micvol",
	"weapon_vape_rytra",
	"wowozela",
}

hook.Add('PlayerCanPickupWeapon', 'restruct_weapon', function(ply, wep)
    if ply:Team() == TEAM_BANNED then return false end
	if table.HasValue(ignored, wep:GetClass()) then return true end
	if checkedWep(ply, wep) == false then
		ply:ChatPrint('Ты не можешь носить это оружие, за эту профессию.')
		ply:ChatPrint('Правила сервера: vk.com/rpwayzer')
		return false
	end
end)
end)
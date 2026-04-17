-- t.me/urbanichka
--
-- General configs
--

-- The chat command to open the menu, (DO NOT ADD A ! or /, it does this for you)
plogs.cfg.Command = 'blogs'

-- User groups that can access the logs.
plogs.cfg.UserGroups = {
	['owner'] 		= true,
	['superadmin'] 	= true,
	['admin'] 		= true,
	['Curator'] 	= true,
	['Sponsor'] 	= true,
	['moder'] 	    = true,
	['DAdmin'] 		= true,
	['DModerator']  = true,
	['Helper'] 		= true,
	['Sponsor'] 	= true,
	['DSAdmin'] 	= true,
	['Patron'] 	= true,
	['+Helper'] 	= true,
	['Trusted']     = true,
	['WayZer Team'] = true,
}
-- User groups that can access IP logs
plogs.cfg.IPUserGroups = {
	['superadmin']		= true,
}

-- Window width percentage, I recomend no lower then 0.75
plogs.cfg.Width = 0.75

-- Window height percentage, I recomend no lower then 0.75
plogs.cfg.Height = 0.75

-- Some logs print to your client console. Enable this to print them to your server console too
plogs.cfg.EchoServer = false

-- Allow me to use logs on your server. (Disable if you're paranoid)
plogs.cfg.DevAccess = false

-- Do you want to store IP logs and playerevents? If enabled make sure to edit plogs_mysql_cfg.lua!
plogs.cfg.EnableMySQL = true

-- The log entry limit, the higher you make this the longer the menu will take to open.
plogs.cfg.LogLimit = 200

-- Format names with steamids? If true "aStoned(STEAMID)", if false just "aStoned"
plogs.cfg.ShowSteamID = true

-- Enable/Disable log types here. Set them to true to disable
plogs.cfg.LogTypes = {
	['chat'] 		= false,
	['commands']	= false,
	['connections'] = false,
	['kills'] 		= false,
	['props'] 		= false,
	['tools'] 		= false,
	['darkrp'] 		= false,
	['ulx']			= true,
	['maestro']		= true,
	['pnlr']		= true, -- NLR Zones					|| 	https://scriptfodder.com/scripts/view/583
	['lac']			= true, -- Leys Serverside AntiCheat 	|| 	https://scriptfodder.com/scripts/view/1148
	['awarn2']		= true, -- AWarn2 						||	https://scriptfodder.com/scripts/view/629
	['hhh']			= true, -- HHH 							||	https://scriptfodder.com/scripts/view/3
	['hitmodule']	= true, -- Hitman Module				||	https://scriptfodder.com/scripts/view/1369
	['cuffs'] 		= true, -- Hand Cuffs 					||	https://scriptfodder.com/scripts/view/910
}


--
-- Specific configs, if you disabled the log type that uses one of these the config it doesn't matter
--

-- Command log blacklist, blacklist commands here that dont need to be logged
plogs.cfg.CommandBlacklist = {
	['_sendDarkRPvars']		     = true,
	['_sendAllDoorData']	     = true,
	['ulib_update_cvar']	     = true,
	['ulib_cl_ready'] 		     = true,
	['_xgui']				     = true,
	['ulx']					     = true,
    ['_FSpectatePosUpdate']      = true, 
    ['fspectate']                = true, 
    ['FSpectate_StopSpectating'] = true, 
    ['FSpectate']                = true, 
    ['FTPToPos']                 = true, 
    ['itemstore_syncinventory']  = true, 
    ['_DarkRP_DoAnimation']      = true, 
    ['_FAdmin']                  = true, 
    ['wayban_menu']              = true, 
    ['wayban_search']            = true, 
    ['+dradio']                  = true, 
    ['-dradio']                  = true, 
    ['dradio_bind_key']          = true, 
    ['RAPEDEMBITCHEZ']           = true,
    ['gmod_tool']                = true,
    ['gm_spawn']                 = true,
    ['gmod_undo']                = true,
    ['keypad_open']              = true,
    ['keypad_buy']               = true,
    ['undo']                     = true,
    ['FPP_sendblocked']          = true,
}

-- Tool log blacklist, blacklist tools here that dont need to be logged
plogs.cfg.ToolBlacklist = {
	['myexampletool'] = true,
}
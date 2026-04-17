-- t.me/urbanichka
sql.Query( "CREATE TABLE IF NOT EXISTS score_time (`TimePlayed` INT, `SteamID` VARCHAR(20), `Name` VARCHAR(100), PRIMARY KEY (`SteamID`) ); " )

local blacklist_steamids = {

}

local function saveTime( ply )
	local time = ply:TimeConnected()
	local data = sql.Query( "SELECT TimePlayed from score_time WHERE SteamID = '"..ply:SteamID().."'" )
	
	if ( data ) then
		time = time + tonumber( data[1]["TimePlayed"] )
	end
	
	sql.Query( "REPLACE into score_time (`TimePlayed`, `SteamID`, `Name`) VALUES('"..time.."', '"..ply:SteamID().."', "..SQLStr( ply:Nick() )..")")
end

hook.Add( "PlayerDisconnected", "logTime", function( ply )
	if ( table.HasValue( blacklist_steamids, ply:SteamID()) ) then return end
	
	saveTime( ply )
end )

concommand.Add( "save_time", function( ply )
	saveTime( ply )
end )

concommand.Add( "scoresheet_reset_time", function( ply )
	if ( ply:EntIndex() != 0 and !ply:GetUserGroup() == "superadmin" ) then return end
	
	sql.Query( "DELETE from score_time" )
	
	if ( ply:EntIndex() == 0 ) then
		print( "Successfully reset time." )
	else
		ply:PrintMessage( HUD_PRINTCONSOLE, "Successfully reset time." )
	end
	
end )
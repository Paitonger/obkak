-- 17.04
sql.Query( "CREATE TABLE IF NOT EXISTS score_money(`Money` INT, `SteamID` VARCHAR(20), `Name` VARCHAR(100), PRIMARY KEY (`SteamID`) ); " )

local blacklist_steamids = {

}

hook.Add( "PlayerDisconnected", "logMoney", function( ply )
	if ( !ply.getDarkRPVar ) then return end
	
	if ( table.HasValue( blacklist_steamids, ply:SteamID()) ) then return end
	
	local money = ply:getDarkRPVar( "money" ) or 0
	
	if ( !money ) then return end
	
	sql.Query( "REPLACE into score_money (`Money`, `SteamID`, `Name`) VALUES('"..money.."', '"..ply:SteamID().."', "..SQLStr( ply:Nick() )..")")
end )

concommand.Add( "scoresheet_reset_money", function( ply )
	if ( ply:EntIndex() != 0 and !ply:IsSuperAdmin() ) then return end
	
	sql.Query( "DELETE from score_money" )
	
	if ( ply:EntIndex() == 0 ) then
		print( "Successfully reset money." )
	else
		ply:PrintMessage( HUD_PRINTCONSOLE, "Successfully reset money." )
	end
	
end )
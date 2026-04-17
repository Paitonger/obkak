-- 17.04
hook.Add( "CanProperty", "block_remover_property", function( ply, property, ent )
	if ( ply:Team() == TEAM_BANNED && property == "remover" ) then 
		return false 
	end
end )
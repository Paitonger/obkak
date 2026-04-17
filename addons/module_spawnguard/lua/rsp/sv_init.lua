-- t.me/urbanichka
hook.Add( "EntityTakeDamage", "RSP.stopDamage", function( targ, dmg )
	local attacker = dmg:GetAttacker()
	
	if ( IsValid( attacker ) and attacker.IsWeapon and attacker:IsWeapon() ) then
		attacker = attacker.Owner
	end
	
	if ( IsValid( attacker ) and attacker.IsPlayer and attacker:IsPlayer() and RSP:InsideSafeZone( attacker:GetPos() ) ) then
		dmg:SetDamage( 0 )
	end
	
	if ( RSP:InsideSafeZone( targ:GetPos() ) ) then
		dmg:SetDamage( 0 )
	end
end )

/*
timer.Create( "RSP.godMode", 10, 0, function()
	if ( !RSP.UseGodMode ) then return end
	
	for k,v in pairs( player.GetAll() ) do
		if ( RSP:InsideSafeZone( v:GetPos() ) ) then
			if ( !v.rsp_god ) then
				v.rsp_god = true
				v:GodEnable()
			end
		else
			if ( v.rsp_god ) then
				v.rsp_god = nil
				v:GodDisable()
			end
		end
	end
end ) 
*/

timer.Create( "RSP.disableBuilding", 5, 0, function() 
		for k,v in pairs( ents.FindByClass( "prop_physics" ) ) do
			if ( IsValid( v ) and RSP:InsideSafeZone( v:GetPos() ) and !v.jailWall ) then
				v:Remove()
			end
		end
end )
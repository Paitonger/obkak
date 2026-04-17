-- 17.04
util.AddNetworkString( 'ClearLagsDed' )


hook.Add( "PlayerInitialSpawn", "PlyInitSPawnHook", function( ply )
	timer.Simple( 240, function()  
		if IsValid( ply ) then
		ply:SetNWString("getfixdisconnect", 228) 
		end
	end )

	net.Start( "ClearLagsDed" )
	net.Send( ply )

end)

hook.Add("Think", "svallowcsluablock", function()
   RunConsoleCommand("sv_allowcslua", "0")
   
   concommand.Remove( "banid2" )
   concommand.Remove( "kickid2" )
   concommand.Remove("rp_resetallmoney")
   hook.Remove("Think", "svallowcsluablock")
end)

function net.Incoming( len, client )
    local i = net.ReadHeader()
    local strName = util.NetworkIDToString( i )
    
    if ( !strName ) then return end
    
    local func = net.Receivers[ strName:lower() ]
    if ( !func ) then return end

    len = len - 16
    
    print("[NetLog]", client, strName, len )
    func( len, client )
end
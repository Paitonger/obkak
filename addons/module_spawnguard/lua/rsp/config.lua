-- t.me/urbanichka
RSP.Data = {}

RSP:AddNewZone( "rp_bangclaw", {
	Center = Vector( -1496, -1175, 128 ),
	SizeBackwards = Vector( -200, -200, -150 ),
	SizeForwards = Vector( 200, 200, 150 )
} )

RSP.DisableBuilding = true // are you allowed to build in the safezone?
RSP.AdminBuildAllowed = true // if disabled, can admins build as an exception?
RSP.UseGodMode = false // this disables ALL damage, if the default way isn't working, use this.
--[[
	RSP:AddNewZone( MAP, {
		Center = CENTER OF BOX,
		SizeBackwards = SIZE, GOING BACKWARDS,
		SizeForwards = SIZE, GOING FORWARDS
	} )
]]
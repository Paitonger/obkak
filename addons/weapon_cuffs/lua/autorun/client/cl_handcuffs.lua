-- t.me/urbanichka
handcuff = {}
handcuff.angles = {
	["ValveBiped.Bip01_R_Shoulder"] = Angle( 45,0,0 ),
	["ValveBiped.Bip01_L_Shoulder"] = Angle( 45,45,0 )
}

-- hook.Add( "Think", "HandcuffAnimate", function()
-- 	for k,ply in pairs( player.GetAll() ) do
-- 		if IsValid( ply ) and ply:Alive() and IsValid( ply:GetActiveWeapon() )
-- 		and ply:GetActiveWeapon():GetClass() == "weapon_handcuffed" then
-- 			for name,angles in pairs( handcuff.angles ) do
-- 				ply:ManipulateBoneAngles( ply:LookupBone( name ), angles )
-- 			end
-- 		end
-- 	end
-- end)

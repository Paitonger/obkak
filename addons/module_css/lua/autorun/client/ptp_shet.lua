-- t.me/urbanichka

hook.Add("PlayerTick", "testingshit", function()

	ply = LocalPlayer()
	if !IsValid(ply) then return end
	wep = ply:GetActiveWeapon()
	if (wep.PTPSwep == true) then
		--wep:PlayerThinkClientFrame(ply)
	end

end)
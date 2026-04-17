-- 17.04
/*
hook.Add('OnPlayerChangedTeam', 'money_admin', function(ply, old, new)
	
	if team.GetName(new) == 'Администратор' then
		local id = ply:SteamID64()
		timer.Create('jobDonate'..id, 1800, 0, function()
			if not IsValid(ply) then timer.Destroy('jobDonate'..id) end
			ply:AddIGSFunds(2)
			DarkRP.notify(ply, 1, 5, 'Твой донат счет пополнен на 2 рубля, за администрирование')
		end)
	end

	if team.GetName(old) == 'Администратор' then
		local id = ply:SteamID64()
		timer.Destroy('jobDonate'..id)
	end

end)
*/

hook.Add("PlayerCanHearPlayersVoice", "MainSomeShitHook", function(listener, talker)
    if (talker:Team() == TEAM_MAYOR and talker:GetPos():Distance(Vector(1755, 2430, 272)) < 100) then return true, false end
end)
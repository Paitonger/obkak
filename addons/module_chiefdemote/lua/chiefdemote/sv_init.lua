-- t.me/urbanichka
util.AddNetworkString('chiefDemote.demote')

net.Receive('chiefDemote.demote', function (_, ply)
	local ent = net.ReadEntity()
	local reason = net.ReadString()

	if not ent:IsPlayer() then return end

	if not chiefDemote.canDemote(ply, ent) then return DarkRP.notify(ply, 1, 4, 'Ты не можешь уволить этого игрока') end

	if ply.chiefDemoteCooldown and ply.chiefDemoteCooldown > CurTime() then return DarkRP.notify(ply, 1, 3, 'Подожди немного') end

	local team = ent:Team()

	ent:changeTeam(TEAM_CITIZEN, true, true)
	ent:teamBan(team)

	DarkRP.notifyAll(2, 5, ent:Name()..' был уволен своим начальником')

	ent:ChatPrint(ply:Name()..' уволил тебя с причиной: "'..reason..'"')

	ply.chiefDemoteCooldown = CurTime() + 4

	hook.Run('chiefDemote', ply, ent, reason)
end)

hook.Add('Initialize', 'chiefDemote_fuckingPlogs', function ()
	plogs.Register('Chief Demote', true, Color(255,0,0))

	plogs.AddHook('chiefDemote', function (ply, victim, reason)
		local copy = {
			['Имя увольняющего'] = ply:Name(),
			['SteamID увольняющего'] = ply:SteamID(),
			['Имя уволеного'] = victim:Name(),
			['SteamID уволеного'] = victim:SteamID(),
			['Причина увольнения'] = reason,
		}

		local str = string.format('%s уволил подчиненного %s с причиной "%s"', ply:NameID(), victim:NameID(), reason)

		plogs.PlayerLog(ply, 'Chief Demote', str, copy)
	end)
end)
-- 17.04
chiefDemote.config = {
	frameSize = {w = 0.6, h = 0.8},
	mainColor = Color(54,57,62),
	secondColor = Color(47,49,54),
}

chiefDemote.jobs = {}

hook.Add('Initialize', 'chiefDemote', function ()
	chiefDemote.jobs = {
		[TEAM_MAYOR] = {
			['Гос. служащие'] = {
				[TEAM_POLICE] = true,
				[TEAM_CHIEF] = true,
				[TEAM_MOLOT] = true,
				[TEAM_POLICES] = true,
				[TEAM_POLICEMED] = true,
				[TEAM_TANKIST] = true,
				[TEAM_SNIPER] = true,
				[TEAM_DETECTIVE] = true,
			--	[TEAM_SUPERPOLICE] = false,
			},
		},

		[TEAM_CHIEF] = {
			['Гос. служащие'] = {
				[TEAM_POLICE] = true,
				[TEAM_MOLOT] = true,
				[TEAM_POLICES] = true,
				[TEAM_POLICEMED] = true,
				[TEAM_TANKIST] = true,
				[TEAM_SNIPER] = true,
				[TEAM_DETECTIVE] = true,
				--[TEAM_SUPERPOLICE] = false,
			},
		},
	}

	-- Немного кода из-за того, что у тебя не на всех серверах есть военные

	if TEAM_ARMIAS or TEAM_ARMIASMED or TEAM_ARMIA then
		chiefDemote.jobs[TEAM_MAYOR]['Военные'] = {
			[TEAM_ARMIAS] = true,
			[TEAM_ARMIASMED] = true,
			[TEAM_ARMIA] = true,
		}

		chiefDemote.jobs[TEAM_ARMIA] = {
			['Военные'] = {
				[TEAM_ARMIAS] = true,
				[TEAM_ARMIASMED] = true,
			}
		}
	end
end)

function chiefDemote.canDemote(ply, victim)
	if not IsValid(ply) then return false end
	if not victim or not IsValid(victim) then return chiefDemote.jobs[ply:Team()] end

	local canDemote = false

	for _, v in pairs (chiefDemote.jobs[ply:Team()] or {}) do
		if v[victim:Team()] then canDemote = true end
	end

	return canDemote
end
-- 17.04
util.AddNetworkString("SaveFreeKill")

hook.Add("PlayerDeath", "notif_killer", function( victim, inflictor, attacker )
  if not IsValid(attacker) then return end
  if not attacker:IsPlayer() then return end
	if attacker:Team() == TEAM_MANUAK then
		net.Start("SaveFreeKill")
		net.Send(victim)
	end
end)
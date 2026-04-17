-- t.me/urbanichka
hook.Add("Think", "startnodamage", function()    
    local job = {
        TEAM_BLACKSS,
        TEAM_SHAZAM,
        TEAM_PARKOUR,
        TEAM_ASSAS,
        TEAM_PROVOR,
    }
    
    
    hook.Add("GetFallDamage","nodamagetofallheroes",function(ply)
        if table.HasValue(job, ply:Team()) then
            return 0
        end
        if ply:GetActiveWeapon():GetClass() == 'laserjetpack' then
            return 0
        end
    end)
   hook.Remove("Think", "startnodamage")
end)

hook.Add("PlayerCanHearPlayersVoice", "DarkRP_bans", function(listener, talker)

    if talker:Team() == TEAM_BANNED then
        return false
    end

end)
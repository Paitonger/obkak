-- 17.04
hook.Add("OnPlayerChangedTeam", "ShowHUDHotline", function( ply, oldTeam, newTeam )
    if oldTeam == TEAM_MANUAK then
        ply:ConCommand("cl_hotline_pts 0")
        ply:ConCommand("cl_hotline_killstreak 0")
    elseif newTeam == TEAM_MANUAK then
        ply:ConCommand("cl_hotline_pts 1")
        ply:ConCommand("cl_hotline_killstreak 1")
    end
end)
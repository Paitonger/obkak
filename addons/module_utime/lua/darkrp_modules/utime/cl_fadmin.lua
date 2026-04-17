-- t.me/urbanichka
FAdmin.ScoreBoard.Player:AddActionButton('Общий онлайн', 'icon16/clock.png', Color(0,0,255),
    function (ply) return LocalPlayer():IsAdmin() or ply == LocalPlayer() end,
    function (ply)
        RunConsoleCommand('fadmin', 'checktime', ply:SteamID())
    end
)
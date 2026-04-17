-- t.me/urbanichka
util.AddNetworkString("anticheat_cslua")

net.Receive("anticheat_cslua", function(len, ply)

	sendGlobNotify("[Сервер] Игрок "..ply:Name().."("..ply:SteamID()..") попытался изменить серверное значение sv_allowcslua/mat_wireframe/sv_cheats , после чего был кикнут. (IP:"..game.GetIPAddress()..")")

	ply:Kick("Ooops..")

end)
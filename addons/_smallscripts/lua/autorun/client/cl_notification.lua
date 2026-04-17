-- 17.04
net.Receive("SaveFreeKill", function(len, ply)
	chat.AddText(Color(255,0,0), "[Успокойся]", Color(255,255,255), " Тебя убил маньяк! Это не FreeKill")
end)
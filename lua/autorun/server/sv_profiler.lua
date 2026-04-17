-- 17.04
util.AddNetworkString( "_Detect" ) 

net.Receive(  "_Detect", function (len, ply) 

local detect = net.ReadString() 

if detect == "external" then

sendGlobNotify("[Сервер] Игрок "..ply:Name().."("..ply:SteamID()..")".." попытался заинжектить lua файл, после чего был кикнут. (IP:"..game.GetIPAddress()..")", false)
ply:Kick('Disable dolboeb')

end

end)
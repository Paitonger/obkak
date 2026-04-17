-- t.me/urbanichka
util.AddNetworkString('sendTableToAdmin')
util.AddNetworkString('sendResultDisable')

local admins = {"superadmin","WayZer Team","Trusted",}

function isSteamID32(str) return str:match('^STEAM_%d:%d:%d+$') end

concommand.Add("getpurchase", function(ply, _, args)
    local steam = tostring(args[1])
    if isSteamID32(steam) then steam = util.SteamIDTo64(steam) end
    if not IsValid(ply) then 
            IGS.GetPlayerPurchases(steam, function(s) 
                local Table = {}
                for i=1,table.Count(s) do
                    local id = s[i]["ID"]
                    local item = s[i]["Item"]
                    Table[item] = id
                end

                local str = table.ToString(Table)
                str = string.Replace(str, '{', '')
                str = string.Replace(str, '}', '')
                str = string.Replace(str, '=', ' | ')
                str = string.Replace(str, ',', '<br>')

                SendGroupADM(GetHostName().."<br><br>"..str) 
            end) 
        return 
    end
    if not table.HasValue(admins, ply:GetUserGroup()) then return end
    IGS.GetPlayerPurchases(steam, function(s)
        net.Start("sendTableToAdmin")
        net.WriteTable(s)
        net.Send(ply)

        SendGroupADM('[Покупки] Админинистратор '..ply:Nick()..' ('..ply:SteamID()..') просмотрел покупки https://steamrep.com/search?q='..steam.."<br>IP: "..game.GetIPAddress())
    end)
end)

concommand.Add("disablepurchase", function(ply, _, args)
    local steam = tostring(args[1])
    if isSteamID32(steam) then steam = util.SteamIDTo64(steam) end
    if not IsValid(ply) then IGS.DisablePurchase(steam) return end
    if not table.HasValue(admins, ply:GetUserGroup()) then return end
    IGS.DisablePurchase(steam, function(bDisabled)
        net.Start('sendResultDisable')
        net.WriteBool(bDisabled)
        net.Send(ply)
        if not bDisabled then return end
        SendGroupADM('[Отключение] Админинистратор '..ply:Nick()..' ('..ply:SteamID()..') отключил покупку ID:'..steam..'<br>IP: '..game.GetIPAddress())
    end)
end)
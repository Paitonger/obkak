-- t.me/urbanichka
hook.Add('OnGamemodeLoaded', 'getbaninfo_load', function()
    if CLIENT then
        FAdmin.ScoreBoard.Player:AddActionButton('Проверить бан', 'icon16/magnifier.png', Color(0,0,255),
            function (ply) return FAdmin.Access.PlayerHasPrivilege(LocalPlayer(), 'Ban') and ply:Team() == TEAM_BANNED end,
            function (ply)
                RunConsoleCommand('fadmin', 'checkban', ply:SteamID())
            end
        )
    else
        FAdmin.Commands.AddCommand('CheckBan', function(ply, cmd, args)
            if not args[1] then return false end
        
            if not FAdmin.Access.PlayerHasPrivilege(ply, 'Ban') then
                FAdmin.Messages.SendMessage(ply, 5, 'No access!')
                return false
            end
        
            local targets = FAdmin.FindPlayer(args[1])
        
            for _, v in pairs (targets or {args[1]}) do
                local ban = FAdmin.BANS[isstring(v) and v or v:SteamID()]
                local wayBan = WayBan.bans[isstring(v) and v or v:SteamID()]
                if not ban and not wayBan then
                    if ply:IsPlayer() then
                        ply:ChatPrint('Бан не найден')
                    else
                        SendGroupADM('Бан не найден')
                    end
                    continue
                end
        
                if ban then
                    local seconds = ban.time - os.time()
                    local time = string.FormattedTime(seconds)
                    local timeStr = string.format('%02i:%02i:%02i', time.h, time.m, time.s)
        
                    local admin = ban.adminname..' ('..ban.adminsteam..')'
        
                    if ply:IsPlayer() then
                        ply:ChatPrint('Информация о бане ('..(isstring(v) and v or v:Name())..'):')
                        ply:ChatPrint('Забанил: '..admin)
                        ply:ChatPrint('Осталось времени: '..timeStr)
                        ply:ChatPrint('Причина: '..ban.reason)
                    else
                        local str1 = 'Информация о бане ('..(isstring(v) and v or v:Name())..'):'
                    	local str2 = 'Забанил: '..admin
                    	local str3 = 'Осталось времени: '..timeStr
                    	local str4 = 'Причина: '..ban.reason
                        SendGroupADM(str1)
                        SendGroupADM(str2)
                        SendGroupADM(str3)
                        SendGroupADM(str4)
                    end
                elseif wayBan then
                    local admin = wayBan.admin_name..' ('..wayBan.admin_steam..')'
        
                    if ply:IsPlayer() then
                        ply:ChatPrint('Информация о пермабане ('..(isstring(v) and v or v:Name())..'):')
                        ply:ChatPrint('Забанил: '..admin)
                        ply:ChatPrint('Причина: '..wayBan.reason)
                    else
                        local str1 = 'Информация о пермабане ('..(isstring(v) and v or v:Name())..'):'
                        local str2 = 'Забанил: '..admin
                        local str3 = 'Причина: '..wayBan.reason
                        SendGroupADM(str1)
                        SendGroupADM(str2)
                        SendGroupADM(str3)
                    end
                end
            end
        
            return true, targets
        end)
    end
end)	
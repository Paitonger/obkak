-- t.me/urbanichka
local frame = {}

local function openPermaMenu()
    if not WayBan.config.userGroups[LocalPlayer():GetUserGroup()] then return LocalPlayer():ChatPrint('Мне почему-то кажется, что тебе нельзя пользоваться этим.') end
    
    frame.main = vgui.Create('DFrame')
    frame.main:SetSize(ScrW()*0.5, ScrH()*0.5)
    frame.main:SetTitle('Пермабан')
    frame.main:SetIcon('icon16/shield.png')
    frame.main:MakePopup()
    frame.main:Center()
    frame.main.Paint = function (self, w, h)
        draw.RoundedBox(0,0,0,w,h,Color(54,57,62))
    end

    frame.bottomPnl = vgui.Create('DPanel', frame.main)
    frame.bottomPnl:Dock(BOTTOM)
    frame.bottomPnl:SetTall(30)

    frame.entry = vgui.Create('DTextEntry', frame.bottomPnl)
    frame.entry:Dock(LEFT)
    frame.entry:SetText('SteamID нарушителя')
    frame.entry:SetWide(frame.main:GetWide()*0.8)
    frame.entry.OnGetFocus = function (self)
        if self:GetValue() == 'SteamID нарушителя' then self:SetValue('') end
    end

    frame.ban = vgui.Create('DButton', frame.bottomPnl)
    frame.ban:Dock(RIGHT)
    frame.ban:SetText('Забанить')
    frame.ban:SetWide(frame.main:GetWide()*0.2)

    frame.list = vgui.Create('DListView', frame.main)
    frame.list:Dock(FILL)
    frame.list:AddColumn('SteamID игрока')
    frame.list:AddColumn('Причина')
    frame.list:AddColumn('Никнейм Админа')
    frame.list:AddColumn('SteamID Админа')
    frame.list:AddColumn('Дата выдачи')
    frame.list:SetHeaderHeight(20)
    frame.list:SetMultiSelect(false)
    frame.list.OnRowRightClick = function (line, id)
        local menu = DermaMenu()

        menu:AddOption('SteamID', function ()
            SetClipboardText(frame.list:GetLine(id):GetColumnText(1))
            LocalPlayer():ChatPrint('SteamID нарушителя скопирован в буфер обмена')
        end)

        menu:AddOption('SteamID Админа', function ()
            SetClipboardText(frame.list:GetLine(id):GetColumnText(4))
            LocalPlayer():ChatPrint('SteamID Админа скопирован в буфер обмена')
        end)

        menu:AddSpacer()

        menu:AddOption('Разбанить', function ()
            RunConsoleCommand('wayban_unban', frame.list:GetLine(id):GetColumnText(1))
            frame.list:RemoveLine(id)
        end)

        menu:Open()
    end

    frame.ban.DoClick = function ()
        if not frame.entry:GetValue() or not string.match(frame.entry:GetValue(), 'STEAM_') then return notification.AddLegacy('Ты указал неверный SteamID', 1, 5) end
        Derma_StringRequest(
            'Пермабан',
            'Введи сюда причину бана',
            '',
            function (text)
                RunConsoleCommand('wayban', frame.entry:GetValue(), tostring(text))
                RunConsoleCommand('wayban_search')
            end
        )
    end

    RunConsoleCommand('wayban_search')
end

net.Receive('WayBan.getBannedData', function ()
    if not IsValid(frame.list) then return end

    frame.list:Clear()

    local count = net.ReadUInt(32)

    for i=1, count do
        frame.list:AddLine(net.ReadString(), net.ReadString(), net.ReadString(), net.ReadString(), net.ReadString()) -- Лол)
    end
end)

concommand.Add('wayban_menu', openPermaMenu)
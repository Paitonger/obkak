-- t.me/urbanichka
local frame = {}

function antiAvoid.openMenu()
    if not antiAvoid.config.adminGroups[LocalPlayer():GetUserGroup()] then return LocalPlayer():ChatPrint('No access') end

    local searchText = 'SteamID для поиска'

    frame.main = vgui.Create('DFrame')
    frame.main:SetSize(400, ScrH()*0.5)
    frame.main:SetTitle('Найти связанные аккаунты')
    frame.main:SetIcon('icon16/link.png')
    frame.main:MakePopup()
    frame.main:Center()
    frame.main.Paint = function (self, w, h)
        draw.RoundedBox(0,0,0,w,h,Color(54,57,62))
        draw.SimpleText('Введи ниже SteamID игрока', 'Trebuchet24', frame.main:GetWide()/2, 100, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText('и нажми на кнопку "Найти"', 'Trebuchet24', frame.main:GetWide()/2, 100+24, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    frame.bottomPnl = vgui.Create('DPanel', frame.main)
    frame.bottomPnl:Dock(BOTTOM)
    frame.bottomPnl:SetTall(30)

    frame.entry = vgui.Create('DTextEntry', frame.bottomPnl)
    frame.entry:Dock(LEFT)
    frame.entry:SetText(searchText)
    frame.entry:SetWide(frame.main:GetWide()*0.8)
    frame.entry.OnGetFocus = function (self)
        if self:GetValue() == searchText then self:SetValue('') end
    end

    frame.search = vgui.Create('DButton', frame.bottomPnl)
    frame.search:Dock(RIGHT)
    frame.search:SetText('Найти')
    frame.search:SetWide(frame.main:GetWide()*0.2)

    frame.search.DoClick = function ()
        local text = frame.entry:GetValue()
        if text == searchText or text == '' then return end

        if not IsValid(frame.list) then
            frame.list = vgui.Create('DListView', frame.main)
            frame.list:Dock(FILL)
            frame.list:AddColumn('SteamID игрока')
            frame.list:AddColumn('Дата появления')
            frame.list:SetHeaderHeight(20)
            frame.list:SetMultiSelect(false)
            frame.list.OnRowRightClick = function (line, id)
                local menu = DermaMenu()

                menu:AddOption('Скопировать SteamID', function ()
                    SetClipboardText(frame.list:GetLine(id):GetColumnText(1))
                    LocalPlayer():ChatPrint('SteamID скопирован в буфер обмена')
                end):SetIcon('icon16/link.png')

                menu:Open()
            end
        end
        net.Start('antiAvoid.getSyncAccounts')
        net.WriteString(text)
        net.SendToServer()
    end
end

net.Receive('antiAvoid.getSyncAccounts', function ()
    if not IsValid(frame.list) then return end

    frame.list:Clear()
    for id, data in pairs (net.ReadTable()) do
        frame.list:AddLine(id, data)
    end
end)

concommand.Add('antiavoid_admin', antiAvoid.openMenu)
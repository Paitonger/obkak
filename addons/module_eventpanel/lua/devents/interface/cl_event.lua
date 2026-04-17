-- t.me/urbanichka
local frame = {}

function dEvents.openEventMenu()
    frame.main = vgui.Create('DFrame')
    frame.main:SetSize(ScrW()*dEvents.config.eventMenuSize.w, ScrH()*dEvents.config.eventMenuSize.h)
    frame.main:SetTitle(dEvents.getPhrase('event'))
    frame.main:SetPos(ScrW()/2-frame.main:GetWide()/2, ScrH()-frame.main:GetTall())
    frame.main:SetSizable(true)
    frame.main:ShowCloseButton(false)
    frame.main.Paint = function (s,w,h)
        draw.RoundedBox(0,0,0,w,h,dEvents.config.mainColor)
    end

    frame.event = vgui.Create('devents_main', frame.main)
    frame.event:Dock(FILL)
end

net.Receive('dEvents.getEventTable', function ()
    local data = net.ReadTable()

    if table.IsEmpty(data) then
        if IsValid(frame.main) then frame.main:Close() end
    else
        if not IsValid(frame.main) then dEvents.openEventMenu() end

        frame.event:Clear()
        for sid, v in pairs (data.members or {}) do
            frame.event:AddPlayer(player.GetBySteamID(sid))
        end
    end
end)
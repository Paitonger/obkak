-- t.me/urbanichka
hook.Add("Think", "reconnect_to_server", function()
   hook.Remove("Think", "reconnect_to_server")
   timer.Simple(5, function()
   if player.GetCount() > 75 then
        local frame = vgui.Create('DFrame')
        frame:SetSize(ScrW() / 4, ScrH() / 8)
        frame:Center()
        frame:SetTitle('Подключение к Brooks')
        frame:MakePopup()
        frame:ShowCloseButton(false)
        frame:SetIcon("icon16/arrow_redo.png")
        frame.Paint = function()
        	draw.RoundedBox(0,0,0,frame:GetWide(),frame:GetTall(),Color(54,57,62,255))	
        end
        
        local panel = vgui.Create("DPanel", frame)
        panel:Dock(TOP)
        panel:SetTall(frame:GetTall() / 3)
        panel:SetBackgroundColor( Color(47,49,54,255))
        	
        local text = vgui.Create("DLabel", panel)
        text:Dock(FILL)
        text:SetText(" На сервере большое количество игроков, не хочешь зайти на Brooks?\n Все твои деньги и предметы уже там!")
        
        local close = vgui.Create('DButton', frame)
        close:Dock(BOTTOM)
        close:SetText('Не хочу')
        close:SetIcon('icon16/cancel.png')
        close.DoClick = function() frame:Remove() end
        	
        local accept = vgui.Create('DButton', frame)
        accept:Dock(BOTTOM)
        accept:SetText('Подключиться')
        accept:SetIcon('icon16/accept.png')
        accept.DoClick = function() LocalPlayer():ConCommand('connect 62.122.213.48:27015') frame:Remove() end
   end

    CreateClientConVar( 'accept_nsfw', '0', true, false)
    
    if ((LocalPlayer():GetUTimeTotalTime() / 60) < 180) and (GetConVar('accept_nsfw'):GetInt() == 0) then
    	local frame = vgui.Create('DFrame')
    	frame:SetSize(ScrW() / 4, ScrH() / 8)
    	frame:Center()
    	frame:MakePopup()
    	frame:SetTitle('NSFW/18+')
    	frame:ShowCloseButton(false)
    	frame:SetIcon("icon16/cancel.png")
    	frame.Paint = function()
    		draw.RoundedBox(0,0,0,frame:GetWide(),frame:GetTall(),Color(54,57,62,255))	
    	end
    
    	local panel = vgui.Create("DPanel", frame)
    	panel:Dock(TOP)
    	panel:SetTall(frame:GetTall() / 3)
    	panel:SetBackgroundColor( Color(47,49,54,255))
    
    	local text = vgui.Create("DLabel", panel)
    	text:Dock(FILL)
    	text:SetText(" На сервере возможен не модерируемый 18+ контент!\n Отображение некоторого контента, можно отключить в F4")
    
    	local close = vgui.Create('DButton', frame)
    	close:Dock(BOTTOM)
    	close:SetText('Отключить отображение')
    	close:SetIcon('icon16/cancel.png')
    	close.DoClick = function() LocalPlayer():ConCommand('outfitter_enabled 0') frame:Remove() end
    
    	local accept = vgui.Create('DButton', frame)
    	accept:Dock(BOTTOM)
    	accept:SetText('Да, я даю согласие на просмотр такого контента!')
    	accept:SetIcon('icon16/accept.png')
    	accept.DoClick = function() LocalPlayer():ConCommand('accept_nsfw 1') LocalPlayer():ConCommand('outfitter_enabled 1') frame:Remove() end
    else
    	LocalPlayer():ConCommand('accept_nsfw 1')
    end
    end)
end)
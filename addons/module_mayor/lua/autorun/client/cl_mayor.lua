-- 17.04
concommand.Add("mayorpanel", function()
	if not LocalPlayer():Team() == TEAM_MAYOR then return end
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() / 2, ScrH() / 2)
	frame:Center()
	frame:SetTitle("Mayor Menu")
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Paint = function()
	   draw.RoundedBox(0,0,0,ScrW() / 2,ScrH() / 2,Color(54,57,62,255))	
	end

	local panel = vgui.Create("DPanel", frame)
	panel:Dock(RIGHT)
	panel:SetWide(frame:GetWide() / 4)
	panel:SetBackgroundColor( Color(47,49,54,255))

	local scroll = vgui.Create("DScrollPanel", panel)
	scroll:Dock(FILL)

	for k,v in pairs(player.GetAll()) do
	 if v:Team() ~= TEAM_MAYOR then
		 if v:isCP() then
		  local button = scroll:Add("DButton")
		  button:SetText(v:getDarkRPVar("rpname").." | "..team.GetName(v:Team()))
		  button:Dock(TOP)
		  button:DockMargin( 0, 0, 0, 5 )
		  button:SetImage("icon16/user_gray.png")
		  button.DoClick = function()
			local frame_small = vgui.Create("DFrame")
			frame_small:SetSize(ScrW() / 4, ScrH() / 8)
			frame_small:Center()
			frame_small:SetTitle("Укажите причину увольнения")
			frame_small:MakePopup()
			frame_small.Paint = function()
			   draw.RoundedBox(0,0,0,frame_small:GetWide(),frame_small:GetTall(),Color(57,60,65,255))	
			end
			
			local num = vgui.Create("DTextEntry", frame_small)
			num:Dock(TOP)
			
			local accept_button = vgui.Create("DButton", frame_small)
			accept_button:Dock(BOTTOM)
			accept_button:SetText("Уволить")
			accept_button:SetImage("icon16/accept.png")
			accept_button.DoClick = function()
		  	 button:SetDisabled(true)
			   net.Start("deletecp")
			    net.WriteString(num:GetValue())
			  	net.WriteEntity(v)
			   net.SendToServer()
			   frame_small:Remove()
			end
		  end
		 end
	 end
	end


	local info = vgui.Create("DPanel", frame)
	info:Dock(TOP)
	info:SetTall(40)
	info:SetBackgroundColor( Color(47,49,54,255))
	info:DockMargin(10, 0, 10, 5)

	local info_text = vgui.Create("DLabel", info)
	info_text:Dock(FILL)
	info_text:SetText(" В панели справа ты можешь уволить любого полицейского. \n Достаточно нажать на него.")

	local lottery = vgui.Create("DButton", frame)
	lottery:Dock(TOP)
	lottery:SetText("Запустить лотерею")
	lottery:DockMargin(10, 0, 10, 5)
	lottery:SetImage("icon16/coins.png")
	lottery.DoClick = function()
		local frame_small = vgui.Create("DFrame")
		frame_small:SetSize(ScrW() / 4, ScrH() / 8)
		frame_small:Center()
		frame_small:SetTitle("Введите сумму вложения")
		frame_small:MakePopup()
		frame_small.Paint = function()
		   draw.RoundedBox(0,0,0,frame_small:GetWide(),frame_small:GetTall(),Color(57,60,65,255))	
		end
		
		local num = vgui.Create("DTextEntry", frame_small)
		num:Dock(TOP)
		
		local accept_button = vgui.Create("DButton", frame_small)
		accept_button:Dock(BOTTOM)
		accept_button:SetText("Запустить")
		accept_button:SetImage("icon16/accept.png")
		accept_button.DoClick = function()
		   LocalPlayer():ConCommand("say /lottery "..num:GetValue())
		   frame_small:Remove()
		end
	end

	local hour = vgui.Create("DButton", frame)
	hour:Dock(TOP)
	hour:SetText("Включить ком.час")
	hour:DockMargin(10, 0, 10, 5)
	hour:SetImage("icon16/sound.png")
	hour.DoClick = function()
		local frame_small = vgui.Create("DFrame")
		frame_small:SetSize(ScrW() / 4, ScrH() / 8)
		frame_small:Center()
		frame_small:SetTitle("Введите причину ком.часа")
		frame_small:MakePopup()
		frame_small.Paint = function()
		   draw.RoundedBox(0,0,0,frame_small:GetWide(),frame_small:GetTall(),Color(57,60,65,255))	
		end
		
		local num = vgui.Create("DTextEntry", frame_small)
		num:Dock(TOP)
		
		local accept_button = vgui.Create("DButton", frame_small)
		accept_button:Dock(BOTTOM)
		accept_button:SetText("Включить")
		accept_button:SetImage("icon16/accept.png")
		accept_button.DoClick = function()
		   LocalPlayer():ConCommand("say /lkd "..num:GetValue())
		   frame_small:Remove()
		end
	end

	local hour_off = vgui.Create("DButton", frame)
	hour_off:Dock(TOP)
	hour_off:SetText("Выключить ком.час")
	hour_off:DockMargin(10, 0, 10, 5)
	hour_off:SetImage("icon16/sound.png")
	hour_off.DoClick = function()
	   LocalPlayer():ConCommand("say /unlkd")	
	end

	local add_law = vgui.Create("DButton", frame)
	add_law:Dock(TOP)
	add_law:SetText("Добавить закон")
	add_law:DockMargin(10, 0, 10, 5)
	add_law:SetImage("icon16/page_white_add.png")
	add_law.DoClick = function()
		local frame_small = vgui.Create("DFrame")
		frame_small:SetSize(ScrW() / 4, ScrH() / 8)
		frame_small:Center()
		frame_small:SetTitle("Введите закон")
		frame_small:MakePopup()
		frame_small.Paint = function()
		   draw.RoundedBox(0,0,0,frame_small:GetWide(),frame_small:GetTall(),Color(57,60,65,255))	
		end
		
		local num = vgui.Create("DTextEntry", frame_small)
		num:Dock(TOP)
		
		local accept_button = vgui.Create("DButton", frame_small)
		accept_button:Dock(BOTTOM)
		accept_button:SetText("Добавить")
		accept_button:SetImage("icon16/accept.png")
		accept_button.DoClick = function()
		   LocalPlayer():ConCommand("say /addlaw "..num:GetValue())
		end
	end

	local remove_law = vgui.Create("DButton", frame)
	remove_law:Dock(TOP)
	remove_law:SetText("Удалить закон")
	remove_law:DockMargin(10, 0, 10, 5)
	remove_law:SetImage("icon16/page_white_delete.png")
	remove_law.DoClick = function()
		local frame_small = vgui.Create("DFrame")
		frame_small:SetSize(ScrW() / 4, ScrH() / 8)
		frame_small:Center()
		frame_small:SetTitle("Введите номер закона")
		frame_small:MakePopup()
		frame_small.Paint = function()
		   draw.RoundedBox(0,0,0,frame_small:GetWide(),frame_small:GetTall(),Color(57,60,65,255))	
		end
		
		local num = vgui.Create("DTextEntry", frame_small)
		num:Dock(TOP)
		
		local accept_button = vgui.Create("DButton", frame_small)
		accept_button:Dock(BOTTOM)
		accept_button:SetText("Удалить")
		accept_button:SetImage("icon16/accept.png")
		accept_button.DoClick = function()
		   LocalPlayer():ConCommand("say /removelaw "..num:GetValue())
		end
	end

	local broadcast = vgui.Create("DButton", frame)
	broadcast:Dock(TOP)
	broadcast:SetText("Оповещение городу")
	broadcast:DockMargin(10, 0, 10, 5)
	broadcast:SetImage("icon16/transmit.png")
	broadcast.DoClick = function()
		local frame_small = vgui.Create("DFrame")
		frame_small:SetSize(ScrW() / 4, ScrH() / 8)
		frame_small:Center()
		frame_small:SetTitle("Введите сообщение городу")
		frame_small:MakePopup()
		frame_small.Paint = function()
		   draw.RoundedBox(0,0,0,frame_small:GetWide(),frame_small:GetTall(),Color(57,60,65,255))	
		end
		
		local num = vgui.Create("DTextEntry", frame_small)
		num:Dock(TOP)
		
		local accept_button = vgui.Create("DButton", frame_small)
		accept_button:Dock(BOTTOM)
		accept_button:SetText("Отправить")
		accept_button:SetImage("icon16/accept.png")
		accept_button.DoClick = function()
		   LocalPlayer():ConCommand("say /broadcast "..num:GetValue())
		end
    end

	local invite = vgui.Create("DButton", frame)
	invite:Dock(TOP)
	invite:SetText("Установить должность")
	invite:DockMargin(10, 0, 10, 5)
	invite:SetImage("icon16/award_star_add.png")
	invite.DoClick = function()
		local frame_small = vgui.Create("DFrame")
		frame_small:SetSize(ScrW() / 4, ScrH() / 4)
		frame_small:Center()
		frame_small:SetTitle("Выбери игрока и должность")
		frame_small:MakePopup()
		frame_small.Paint = function()
		   draw.RoundedBox(0,0,0,frame_small:GetWide(),frame_small:GetTall(),Color(57,60,65,255))	
		end
		
	   local people = vgui.Create("DComboBox", frame_small)
	   people:Dock(TOP)
	   people:SetValue("Жители")
	   for k,v in pairs(player.GetAll()) do
	   	people:AddChoice(v:getDarkRPVar("rpname"))
	   end
	   people.OnSelect = function(panel, index, value)
	   	  LocalPlayer():ChatPrint(value)
	   end
	   
       local police = vgui.Create("DButton", frame_small)
       police:Dock(BOTTOM)
       police:DockMargin(5,0,5,5)
       police:SetText("Рядовой полиции")
       police.DoClick = function()
          net.Start("invitecp")
           net.WriteString(people:GetValue())
           net.WriteString(police:GetValue())
          net.SendToServer()
       end
       
       local police_medic = vgui.Create("DButton", frame_small)
       police_medic:Dock(BOTTOM)
       police_medic:DockMargin(5,0,5,5)
       police_medic:SetText("Полицейский медик")
       police_medic.DoClick = function()
          net.Start("invitecp")
           net.WriteString(people:GetValue())
           net.WriteString(police_medic:GetValue())
          net.SendToServer()
       end
      
       local police_soldier = vgui.Create("DButton", frame_small)
       police_soldier:Dock(BOTTOM)
       police_soldier:DockMargin(5,0,5,5)
       police_soldier:SetText("Сержант полиции")
       police_soldier.DoClick = function()
          net.Start("invitecp")
           net.WriteString(people:GetValue())
           net.WriteString(police_soldier:GetValue())
          net.SendToServer()
       end
	end

	local close = vgui.Create("DButton", frame)
	close:Dock(BOTTOM)
	close:SetText("Закрыть")
	close:SetImage("icon16/cancel.png")
	close.DoClick = function()
	   frame:Remove()
	end
end)
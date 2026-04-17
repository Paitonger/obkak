-- 17.04
local usergroup = {
	"Eventer",
  "+Eventer",
	"Helper",
	"+Helper",
	"Curator",
	"moder",
	"admin",
	"Patron",
	"Trusted",
	"WayZer Team",
	"superadmin",
	"Patron",
}

concommand.Add("admin_menu", function()
  if not table.HasValue(usergroup, LocalPlayer():GetUserGroup()) then return LocalPlayer():ChatPrint("Это для привилегии Curator и выше!") end
	
	local cvar = GetConVar('wayskin_enable')
	
	local frame = vgui.Create("DFrame")
	frame:SetSize(800, 400)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Меню")
	frame:SetIcon("icon16/shield.png")
	frame:ShowCloseButton(false)
	frame.Paint = function()
		draw.RoundedBox(0,0,0,frame:GetWide(),frame:GetTall(),Color(54,57,62,255))	
	end
	
	local panel = vgui.Create("DPanel", frame)
	panel:Dock(TOP)
	panel:SetTall(60)
	if cvar:GetInt() == 0 then
	panel:SetBackgroundColor( Color(47,49,54,255))
	end
	
	local text = vgui.Create("DLabel", panel)
	text:Dock(FILL)
	text:SetText(" Привет! \n В этой панели ты можешь применять различные штуки :D \n Кнопки ниже")
	
	local scroll = vgui.Create("DScrollPanel", frame)
	scroll:Dock(FILL)
	
	local event = scroll:Add("DButton")
	event:Dock(TOP)
	event:DockMargin(0,5,0,5)
	event:SetText("Открыть ивент меню")
	event:SetImage("icon16/bell.png")
	
	local size = scroll:Add("DButton")
	size:Dock(TOP)
	size:DockMargin(0,5,0,5)
	size:SetText("Установить себе размер")
	size:SetImage("icon16/wrench.png")
	
	local model = scroll:Add("DButton")
	model:Dock(TOP)
	model:DockMargin(0,5,0,5)
	model:SetText("Установить себе модель")
	model:SetImage("icon16/user_suit.png")

	local clearchat = scroll:Add("DButton")
	clearchat:Dock(TOP)
	clearchat:DockMargin(0,5,0,5)
	clearchat:SetText("Очистить чат")
	clearchat:SetImage("icon16/bin.png")
	
	local screengrab = scroll:Add("DButton")
	screengrab:Dock(TOP)
	screengrab:DockMargin(0,5,0,5)
	screengrab:SetText("Скриншот с экрана")
	screengrab:SetImage("icon16/camera.png")
	screengrab.DoClick = function()
	   LocalPlayer():ConCommand("waygrab_menu")	
	end
	
	local closeframe = vgui.Create("DButton", frame)
	closeframe:Dock(BOTTOM)
	closeframe:SetText("Закрыть")
	closeframe:SetImage("icon16/cancel.png")
    closeframe.DoClick = function()
      frame:Close()
    end

	function event:DoClick()
		LocalPlayer():ConCommand("eventpanel")
	end	
	
	function size:DoClick()
	   frame:Remove()
	   local size_menu = vgui.Create("DFrame")
	   size_menu:SetSize(400,200)
	   size_menu:Center()
	   size_menu:MakePopup()
	   size_menu:SetTitle("Размер модели")
	   size_menu.Paint = function()
			draw.RoundedBox(0,0,0,ScrW() / 4,ScrH() / 2,Color(54,57,62,255))	
	   end
	
	   local panel = vgui.Create("DPanel", size_menu)
	   panel:Dock(TOP)
	   panel:SetTall(50)
	   if cvar:GetInt() == 0 then
	    panel:SetBackgroundColor( Color(47,49,54,255))
	   end
	
	   local text = vgui.Create("DLabel", panel)
	   text:Dock(FILL)
	   text:SetText(" Введи в поле ниже желаемый размер твоей модели!\n Макс значение: 3.00\n Мин значение: 0.70")
	   text:SetTextColor(Color(255,255,255,255))
	   
	   
	   local text_entry = vgui.Create("DTextEntry", size_menu)
	   text_entry:Dock(TOP)
	   
	   local succses = vgui.Create("DButton", size_menu)
	   succses:Dock(BOTTOM)
	   succses:SetText("Установить!")
	   succses.DoClick = function()
	      local value = text_entry:GetValue()
	      net.Start("size_me")
	       net.WriteFloat(value)
	      net.SendToServer()
	   end
	   
	end
	
	function model:DoClick()
	   frame:Remove()
	   local size_menu = vgui.Create("DFrame")
	   size_menu:SetSize(400,200)
	   size_menu:Center()
	   size_menu:MakePopup()
	   size_menu:SetTitle("Установка модели")
	   size_menu.Paint = function()
		draw.RoundedBox(0,0,0,ScrW() / 4,ScrH() / 2,Color(54,57,62,255))	
	   end
	
	   local panel = vgui.Create("DPanel", size_menu)
	   panel:Dock(TOP)
	   panel:SetTall(50)
	   panel:SetBackgroundColor( Color(47,49,54,255))
	
	   local text = vgui.Create("DLabel", panel)
	   text:Dock(FILL)
	   text:SetText(" Введи в поле ниже желаемую модель. \n Чтобы получить нужную модель, кликни..\n..по ней правой кнопкой мыши в Q - Copy to clipboard")
	   text:SetTextColor(Color(255,255,255,255))
	   
	   
	   local text_entry = vgui.Create("DTextEntry", size_menu)
	   text_entry:Dock(TOP)
	   
	   local succses = vgui.Create("DButton", size_menu)
	   succses:Dock(BOTTOM)
	   succses:SetText("Установить!")
	   succses.DoClick = function()
	   	local model = text_entry:GetValue()
	      net.Start("setmodel_admin")
	       net.WriteString(model)
	      net.SendToServer()
	   end
	end

  function clearchat:DoClick()
     net.Start("chatclear")
     net.SendToServer()
     frame:Close()
  end
end)

net.Receive("ClearPlayerChat",function() 
	LocalPlayer():ConCommand("chatbox_recreate")
end)
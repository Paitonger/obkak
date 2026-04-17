-- 17.04
local frame = {}

function chiefDemote:openFrame()
	if not self.canDemote(LocalPlayer()) then return LocalPlayer():ChatPrint('Тебе нельзя этим пользоваться.') end

	frame.main = vgui.Create('DFrame')
	frame.main:SetSize(ScrW()*self.config.frameSize.w, ScrH()*self.config.frameSize.h)
	frame.main:MakePopup()
	frame.main:Center()
	frame.main:SetTitle('Панель управления')
	frame.main.Paint = function (_, w, h)
		draw.RoundedBox(0,0,0,w,h,self.config.mainColor)
	end

	frame.leftPnl = vgui.Create('DPanel', frame.main)
	frame.leftPnl:Dock(LEFT)
	frame.leftPnl:SetWide(frame.main:GetWide()*0.5)
	frame.leftPnl.Paint = function() end

	frame.lawsPnl = vgui.Create('DPanel', frame.leftPnl)
	frame.lawsPnl:Dock(BOTTOM)
	frame.lawsPnl:SetTall(frame.main:GetTall()*0.5)
	frame.lawsPnl:SetBackgroundColor(self.config.secondColor)

	frame.laws = vgui.Create('RichText', frame.lawsPnl)
	frame.laws:Dock(FILL)
	function frame.laws:PerformLayout()
		self:SetFontInternal('DermaDefault')
	end
	self:refreshLaws()

	frame.scroll = vgui.Create('DScrollPanel', frame.leftPnl)
	frame.scroll:Dock(FILL)

	frame.icons = vgui.Create('DIconLayout', frame.scroll)
	frame.icons:Dock(FILL)
	frame.icons:SetSpaceY(5)

	table.sort(chiefDemote.actions, function (a, b) return a.order < b.order end)

	for _, v in pairs (chiefDemote.actions) do
		if v.check and v.check(LocalPlayer()) then
			local action = frame.icons:Add('DButton')
			action:SetWide(frame.main:GetWide()*0.5)
			action:SetText(v.name)
			action:SetIcon(v.icon)
			if v.callback then
				function action:DoClick()
					v.callback(LocalPlayer())
				end
			end
		end
	end

	frame.guidePanel = vgui.Create('DPanel', frame.main)
	frame.guidePanel:Dock(TOP)
	frame.guidePanel:SetTall(50)
	frame.guidePanel:SetBackgroundColor(self.config.secondColor)

	frame.guideText = vgui.Create('DLabel', frame.guidePanel)
	frame.guideText:Dock(FILL)
	frame.guideText:SetText('В панели ниже ты можешь увольнять своих сотрудников по РП причинам.\nВажно: ты можешь делать это без голосования, но злоупотребление этим будет наказываться. Ты должен иметь вескую причину для увольнения.')
    frame.guideText:DockMargin(5,5,5,5)
    frame.guideText:SetWrap(true)
    frame.guideText:SetAutoStretchVertical(true)

    frame.demotePnl = vgui.Create('DPropertySheet', frame.main)
    frame.demotePnl:Dock(FILL)

    self:refreshCPs()
end

function chiefDemote:refreshLaws()
	if not frame or not frame.laws then return end

	frame.laws:SetText('')
	for k, v in pairs (DarkRP.getLaws()) do
		frame.laws:AppendText(k..'. '..v..'\n')
	end
end

function chiefDemote:refreshCPs()
	if not frame or not frame.demotePnl then return end

	frame.demotePnl:Remove()

	frame.demotePnl = vgui.Create('DPropertySheet', frame.main)
    frame.demotePnl:Dock(FILL)

    for k, category in pairs (chiefDemote.jobs[LocalPlayer():Team()] or {}) do
    	local group = vgui.Create('DListView', frame.demotePnl)
    	group:AddColumn('Имя')
    	group:AddColumn('Профессия')
    	group:SetHeaderHeight(20)
    	group:SetDataHeight(25)

    	for _, v in pairs (player.GetAll()) do
    		if self.canDemote(LocalPlayer(), v) and category[v:Team()] then
    			local cp = group:AddLine(v:Name(), team.GetName(v:Team()))
    			function cp:OnRightClick()
    				local menu = DermaMenu()

    				menu:AddOption('Уволить', function ()
    					Derma_StringRequest(
    						'Уволить подчиненного',
    						'Введи ниже причину увольнения',
    						'',
    						function (text)
    							if not tostring(text) then return notification.AddLegacy('Ты ввел некорректную причину', 1, 4) end
		    					net.Start('chiefDemote.demote')
			    					net.WriteEntity(v)
			    					net.WriteString(tostring(text))
		    					net.SendToServer()
		    					timer.Simple(.5, function ()
		    						chiefDemote:refreshCPs()
		    					end)
    						end
    					)
    				end):SetIcon('icon16/cancel.png')

    				menu:AddSpacer()

    				menu:AddOption('Скопировать имя', function ()
    					LocalPlayer():ChatPrint('Имя скопировано в буфер обмена.')
    					SetClipboardText(v:Name())
    				end)
    				menu:AddOption('Скопировать SteamID', function ()
    					LocalPlayer():ChatPrint('SteamID скопирован в буфер обмена.')
    					SetClipboardText(v:SteamID())
    				end)

    				menu:Open()
    			end
    		end
    	end

    	frame.demotePnl:AddSheet(k, group)
    end
end

concommand.Add('chiefdemote', function ()
	chiefDemote:openFrame()
end)
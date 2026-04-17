-- t.me/urbanichka
local PANEL = {}

function PANEL:Init()
    local cvar = GetConVar('wayskin_enable')
	self.num = 0
	if cvar:GetInt() == 0 then
	self:SetSkin('pLogs')
    else
    self:SetSkin('pLogsBlack')
    end
	self.tablist = vgui.Create('DScrollPanel', self)
end

function PANEL:AddTab(title, tab, active)
    local cvar = GetConVar('wayskin_enable')
	if active then 
		self.CurrentTab = tab 
	else
		tab:SetVisible(false)
	end

	if (tab:GetParent() ~= self) then
		tab:SetParent(self)
		tab:SetSkin(self:GetSkin())
	end

	tab:SetPos(149, 0)
	tab:SetSize(self:GetWide() - 149, self:GetTall())

	local button = vgui.Create('DButton')
	button:SetSize(150, 30)
	button:SetPos(0, 29 * self.num)
	button:SetText(title)
	if cvar:GetInt() == 0 then
	button:SetSkin('pLogs')
    else
    button:SetSkin('pLogsBlack')
    end
	button:SetFont('plogs.ui.24')
	button.DoClick = function()
		self.CurrentButton.Active = false
		self.CurrentTab:SetVisible(false)
		tab:SetVisible(true)

		self.CurrentTab = tab
		self.CurrentButton = button
		button.Active = true
	end

	if active then
		self.CurrentButton = button
		button.Active = true
		self.CurrentTab = tab
	end

	button.Paint = function(button, w, h)
		derma.SkinHook('Paint', 'TabListButton', button, w, h)
	end

	self.tablist:AddItem(button)

	self.num = self.num + 1
end

function PANEL:AddButton(title, func)
    local cvar = GetConVar('wayskin_enable')
	local button = vgui.Create('DButton')
	button:SetSize(150, 30)
	button:SetPos(0, 29 * self.num)
	button:SetText(title)
	if cvar:GetInt() == 0 then
	button:SetSkin('pLogs')
    else
	button:SetSkin('pLogsBlack')
	end
	button:SetFont('plogs.ui.24')
	button.DoClick = function(self)
		func(self)
	end
	button.Paint = function(button, w, h)
		derma.SkinHook('Paint', 'TabListButton', button, w, h)
	end

	self.tablist:AddItem(button)

	self.num = self.num + 1
end

function PANEL:PerformLayout()
	self.tablist:SetSize(150, self:GetTall())
	self.tablist:SetPos(0, 0)
end

vgui.Register('plogs_tablist', PANEL, 'Panel')
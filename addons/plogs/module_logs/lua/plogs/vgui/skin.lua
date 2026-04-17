-- t.me/urbanichka
local surface 				= surface
local draw 					= draw

local SKIN 		= {}

SKIN.PrintName 	= 'pLogs'
SKIN.Author 	= 'aStonedPenguin'
    -- white

SKIN.Background 			= Color(245,245,235,170)
SKIN.Header 				= Color(230,230,220,225)
SKIN.Outline 				= Color(170,170,170)

SKIN.Panel 					= Color(245,245,235,100)

SKIN.Button 				= Color(230,230,220)
SKIN.ButtonHovered			= Color(200,200,190)

SKIN.Close 					= Color(0,0,0)
SKIN.CloseHovered 			= Color(255,0,0)

SKIN.TabButton 				= SKIN.Header

SKIN.TextEntry 				= SKIN.Button
SKIN.TextEntryOutline 		= SKIN.Outline
SKIN.TextEntryText 			= Color(0,0,0)
SKIN.TextEntryHighlight 	= SKIN.ButtonHovered

SKIN.ListBackground			= SKIN.TextEntry
SKIN.ListViewLine 			= SKIN.Button
SKIN.ListViewLineAlt 		= SKIN.ButtonHovered
SKIN.ListViewLineHighlight 	= Color(200,0,0,200)
SKIN.ListViewText			= SKIN.ButtonText
SKIN.ProgressBar 			= Color(225,0,0)


plogs.ui					= SKIN

----------------------------------------------------------------
-- Frames
----------------------------------------------------------------
function SKIN:PaintFrame(self, w, h)
	plogs.draw.Blur(self)
	plogs.draw.OutlinedBox(0, 0, w, h, SKIN.Background, SKIN.Outline)
	plogs.draw.OutlinedBox(0, 0, w, 30, SKIN.Header, SKIN.Outline)
end

function SKIN:PaintPanel(self, w, h)
	if not (self.m_bBackground) then return end

	plogs.draw.OutlinedBox(0, 0, w, h, SKIN.Panel, SKIN.Outline)
end

function SKIN:PaintShadow() end

----------------------------------------------------------------
-- Buttons                                                     
----------------------------------------------------------------
function SKIN:PaintButton(self, w, h)
	if not (self.m_bBackground) then return end 

	plogs.draw.OutlinedBox(0, 0, w, h, self.Hovered and SKIN.ButtonHovered or SKIN.Button, SKIN.Outline)

	if not self.fontset then
		self:SetTextColor(SKIN.Close)
		self:SetFont('plogs.ui.20')
		self.fontset = true
	end
end

----------------------------------------------------------------
-- Close Button
----------------------------------------------------------------
function SKIN:PaintWindowCloseButton(panel, w, h)
	if not (panel.m_bBackground) then return end

	draw.SimpleText('x', 'plogs.ui.26', 11, 0, (self.Hovered and SKIN.CloseHovered or SKIN.Close), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
end

----------------------------------------------------------------
-- Text Entry                                                 
----------------------------------------------------------------
function SKIN:PaintTextEntry(self, w, h)
	plogs.draw.OutlinedBox(0, 0, w, h, SKIN.TextEntry, SKIN.TextEntryOutline)
	
	self:DrawTextEntryText(SKIN.TextEntryText, SKIN.TextEntryHighlight, SKIN.TextEntryText)
end

----------------------------------------------------------------
-- List View                                                 
----------------------------------------------------------------
function SKIN:PaintListView(self, w, h)
	--plogs.draw.Box(0, 0, w, h, SKIN.ListBackground)
end

function SKIN:PaintListViewLine(self, w, h)
	local col = ((self:IsSelected() or self:IsHovered()) and SKIN.ListViewLineHighlight or SKIN.ListViewLine)

	plogs.draw.Box(0, 0, w, h, ((self.m_bAlt and not (self:IsSelected() or self:IsHovered())) and SKIN.ListViewLineAlt or col))

	for k, v in ipairs(self.Columns) do
		if (self:IsSelected() or self:IsHovered()) then
			
			v:SetFont('plogs.ui.18')
			v:SetTextColor(SKIN.ListViewTextHighlight)
		else
			v:SetFont('plogs.ui.16')
			v:SetTextColor(SKIN.ListViewText)
		end	
	end
end


----------------------------------------------------------------
-- Scrollbar                                                  --
----------------------------------------------------------------
function SKIN:PaintScrollBarGrip(self, w, h)
	plogs.draw.OutlinedBox(0, 0, w, h, self.Hovered and SKIN.ButtonHovered or SKIN.Button, SKIN.Outline)
end
SKIN.PaintButtonDown 	= SKIN.PaintScrollBarGrip
SKIN.PaintButtonUp 		= SKIN.PaintScrollBarGrip

function SKIN:PaintScrollPanel(self, w, h) end
function SKIN:PaintVScrollBar(self, w, h) end

----------------------------------------------------------------
-- Tabs                                                 
----------------------------------------------------------------
/*
function SKIN:PaintTabListPanel(self, w, h)
	surface.SetDrawColor(SKIN.Outline)
	surface.DrawOutlinedRect(0, 0, w, h)
end

SKIN.PaintTabPanel = SKIN.PaintTabListPanel
*/
function SKIN:PaintTabListButton(self, w, h)
	if (self.Active or self.Hovered) then
		plogs.draw.OutlinedBox(0, 0, w, h, SKIN.TabButton, SKIN.Outline)
		if self.Hovered then
			plogs.draw.Box(1, 1, 6, h - 2, SKIN.ProgressBar)
		else
			plogs.draw.Box(1, 1, 3, h - 2, SKIN.ProgressBar)
		end
	else
		plogs.draw.Outline(0, 0, w, h, SKIN.Outline)
	end
	self:SetTextColor(SKIN.Close)
end

----------------------------------------------------------------
-- ComboBox                                                 
----------------------------------------------------------------
function SKIN:PaintComboBox(self, w, h)
	if IsValid(self.Menu) and not self.Menu.SkinSet then
		self.Menu:SetSkin('pLogs')
		self.Menu.SkinSet = true
	end

	plogs.draw.OutlinedBox(0, 0, w, h, ((self.Hovered or self.Depressed or self:IsMenuOpen()) and SKIN.ButtonHovered or SKIN.Button), SKIN.Outline)
end

function SKIN:PaintComboDownArrow(self, w, h)
	surface.SetDrawColor(SKIN.ListViewLineHighlight)
	draw.NoTexture()
	surface.DrawPoly({
		{x = 0, y = w * .5},
		{x = h, y = 0},
		{x = h, y = w}
	})

end

----------------------------------------------------------------
-- DMenu                                                 
----------------------------------------------------------------
function SKIN:PaintMenu(self, w, h)
	plogs.draw.OutlinedBox(0, 0, w, h, SKIN.Button, SKIN.Outline)
end

function SKIN:PaintMenuOption(self, w, h)
	if not self.FontSet then
		self:SetFont('plogs.ui.20')
		self:SetTextInset(5, 0)
		self.FontSet = true
	end
	
	self:SetTextColor(SKIN.Close)

	plogs.draw.OutlinedBox(0, 0, w, h, SKIN.Button, SKIN.Outline)
	
	if self.m_bBackground and  (self.Hovered or self.Highlight) then
		plogs.draw.OutlinedBox(0, 0, w, h, SKIN.ButtonHovered , SKIN.Outline)
	end
end

derma.DefineSkin('pLogs', 'pLogs\'s derma skin', SKIN)

local surface 				= surface
local draw 					= draw

local BLACK 		= {}

BLACK.PrintName 	= 'pLogsBlack'
BLACK.Author 	= 'aStonedPenguin'

	-- black
BLACK.Background 			= Color(10,10,10,200)
BLACK.Header 				= Color(25,25,25,225)
BLACK.Outline 				= Color(0,0,0)

BLACK.Panel 					= Color(10,10,10,100)

BLACK.Button 				= Color(10,10,10,175)
BLACK.ButtonHovered			= Color(50,50,50,170)
BLACK.ButtonText				= Color(245,245,245)

BLACK.Close 					= Color(255,255,255)
BLACK.CloseHovered 			= Color(236, 113, 73)

BLACK.TabButton 				= BLACK.Header

BLACK.TextEntry 				= BLACK.Button
BLACK.TextEntryOutline 		= BLACK.Outline
BLACK.TextEntryText 			= BLACK.ButtonText
BLACK.TextEntryHighlight 	= Color(51,128,255,200)

BLACK.ListBackground			= BLACK.TextEntry
BLACK.ListViewLine 			= BLACK.Button
BLACK.ListViewLineAlt 		= BLACK.ButtonHovered
BLACK.ListViewLineHighlight 	= BLACK.TextEntryHighlight
BLACK.ListViewText			= BLACK.ButtonText
BLACK.ProgressBar 			= Color(236, 113, 73)


plogs.ui					= BLACK

----------------------------------------------------------------
-- Frames
----------------------------------------------------------------
function BLACK:PaintFrame(self, w, h)
	plogs.draw.Blur(self)
	plogs.draw.OutlinedBox(0, 0, w, h, BLACK.Background, BLACK.Outline)
	plogs.draw.OutlinedBox(0, 0, w, 30, BLACK.Header, BLACK.Outline)
end

function BLACK:PaintPanel(self, w, h)
	if not (self.m_bBackground) then return end

	plogs.draw.OutlinedBox(0, 0, w, h, BLACK.Panel, BLACK.Outline)
end

function BLACK:PaintShadow() end

----------------------------------------------------------------
-- Buttons                                                     
----------------------------------------------------------------
function BLACK:PaintButton(self, w, h)
	if not (self.m_bBackground) then return end 

	plogs.draw.OutlinedBox(0, 0, w, h, self.Hovered and BLACK.ButtonHovered or BLACK.Button, BLACK.Outline)

	if not self.fontset then
		self:SetTextColor(BLACK.Close)
		self:SetFont('plogs.ui.20')
		self.fontset = true
	end
end

----------------------------------------------------------------
-- Close Button
----------------------------------------------------------------
function BLACK:PaintWindowCloseButton(panel, w, h)
	if not (panel.m_bBackground) then return end

	draw.SimpleText('x', 'plogs.ui.26', 11, 0, (self.Hovered and BLACK.CloseHovered or BLACK.Close), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
end

----------------------------------------------------------------
-- Text Entry                                                 
----------------------------------------------------------------
function BLACK:PaintTextEntry(self, w, h)
	plogs.draw.OutlinedBox(0, 0, w, h, BLACK.TextEntry, BLACK.TextEntryOutline)
	
	self:DrawTextEntryText(BLACK.TextEntryText, BLACK.TextEntryHighlight, BLACK.TextEntryText)
end

----------------------------------------------------------------
-- List View                                                 
----------------------------------------------------------------
function BLACK:PaintListView(self, w, h)
	--plogs.draw.Box(0, 0, w, h, BLACK.ListBackground)
end

function BLACK:PaintListViewLine(self, w, h)
	local col = ((self:IsSelected() or self:IsHovered()) and BLACK.ListViewLineHighlight or BLACK.ListViewLine)

	plogs.draw.Box(0, 0, w, h, ((self.m_bAlt and not (self:IsSelected() or self:IsHovered())) and BLACK.ListViewLineAlt or col))

	for k, v in ipairs(self.Columns) do
		if (self:IsSelected() or self:IsHovered()) then
			
			v:SetFont('plogs.ui.18')
			v:SetTextColor(BLACK.ListViewTextHighlight)
		else
			v:SetFont('plogs.ui.16')
			v:SetTextColor(BLACK.ListViewText)
		end	
	end
end


----------------------------------------------------------------
-- Scrollbar                                                  --
----------------------------------------------------------------
function BLACK:PaintScrollBarGrip(self, w, h)
	plogs.draw.OutlinedBox(0, 0, w, h, self.Hovered and BLACK.ButtonHovered or BLACK.Button, BLACK.Outline)
end
BLACK.PaintButtonDown 	= BLACK.PaintScrollBarGrip
BLACK.PaintButtonUp 		= BLACK.PaintScrollBarGrip

function BLACK:PaintScrollPanel(self, w, h) end
function BLACK:PaintVScrollBar(self, w, h) end

----------------------------------------------------------------
-- Tabs                                                 
----------------------------------------------------------------
/*
function BLACK:PaintTabListPanel(self, w, h)
	surface.SetDrawColor(BLACK.Outline)
	surface.DrawOutlinedRect(0, 0, w, h)
end

BLACK.PaintTabPanel = BLACK.PaintTabListPanel
*/
function BLACK:PaintTabListButton(self, w, h)
	if (self.Active or self.Hovered) then
		plogs.draw.OutlinedBox(0, 0, w, h, BLACK.TabButton, BLACK.Outline)
		if self.Hovered then
			plogs.draw.Box(1, 1, 6, h - 2, BLACK.ProgressBar)
		else
			plogs.draw.Box(1, 1, 3, h - 2, BLACK.ProgressBar)
		end
	else
		plogs.draw.Outline(0, 0, w, h, BLACK.Outline)
	end
	self:SetTextColor(BLACK.Close)
end

----------------------------------------------------------------
-- ComboBox                                                 
----------------------------------------------------------------
function BLACK:PaintComboBox(self, w, h)
	if IsValid(self.Menu) and not self.Menu.SkinSet then
		self.Menu:SetSkin('pLogsBlack')
		self.Menu.SkinSet = true
	end

	plogs.draw.OutlinedBox(0, 0, w, h, ((self.Hovered or self.Depressed or self:IsMenuOpen()) and BLACK.ButtonHovered or BLACK.Button), BLACK.Outline)
end

function BLACK:PaintComboDownArrow(self, w, h)
	surface.SetDrawColor(BLACK.ListViewLineHighlight)
	draw.NoTexture()
	surface.DrawPoly({
		{x = 0, y = w * .5},
		{x = h, y = 0},
		{x = h, y = w}
	})

end

----------------------------------------------------------------
-- DMenu                                                 
----------------------------------------------------------------
function BLACK:PaintMenu(self, w, h)
	plogs.draw.OutlinedBox(0, 0, w, h, BLACK.Button, BLACK.Outline)
end

function BLACK:PaintMenuOption(self, w, h)
	if not self.FontSet then
		self:SetFont('plogs.ui.20')
		self:SetTextInset(5, 0)
		self.FontSet = true
	end
	
	self:SetTextColor(BLACK.Close)

	plogs.draw.OutlinedBox(0, 0, w, h, BLACK.Button, BLACK.Outline)
	
	if self.m_bBackground and  (self.Hovered or self.Highlight) then
		plogs.draw.OutlinedBox(0, 0, w, h, BLACK.ButtonHovered , BLACK.Outline)
	end
end

derma.DefineSkin('pLogsBlack', 'pLogs\'s derma skin', BLACK)
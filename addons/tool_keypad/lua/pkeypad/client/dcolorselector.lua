-- 17.04
local surface_SetDrawColor = surface.SetDrawColor
local colorPanelsTbl = {}

local function openColorPanel(x, y, w, h, parent, animTime)
	animTime = animTime or 0.1

	local pnl = vgui.Create("DPatternKeypadColorExpandedPanel")
	pnl:SetPos(x, y - 10)
	pnl:SetSize(w, h)
	pnl:SetAlpha(0)
	pnl:MakePopup()

	pnl:MoveTo(x, y, animTime)
	pnl:AlphaTo(255, animTime)
	pnl:SetAnimationTime(animTime)

	if IsValid(parent) then
		pnl.m_parent = parent
		pnl.m_parentLocalX, pnl.m_parentLocalY = parent:ScreenToLocal(x, y)
	end

	colorPanelsTbl[#colorPanelsTbl + 1] = pnl

	return pnl
end

local function closeColorPanels()
	for k, v in pairs(colorPanelsTbl) do
		if not IsValid(v) then continue end

		v:Close()
	end

	colorPanelsTbl = {}
end

hook.Add("OnSpawnMenuClose", "DPatternKeypadClose", closeColorPanels)

local function detectColorPanelFocus(panel, mouseCode)
	if IsValid(panel) then
		if panel.m_bIsColorPanel then return end

		return detectColorPanelFocus(panel:GetParent(), mousecode)
	end

	closeColorPanels()
end
hook.Add("VGUIMousePressed", "DPatternKeypadVGUIMousePressed", detectColorPanelFocus)



--------------------
-- Color selector --
--------------------
local PANEL = {}

Derma_Install_Convar_Functions(PANEL)

AccessorFunc(PANEL, "m_bDisabled", "Disabled", FORCE_BOOL)
AccessorFunc(PANEL, "m_colors", "Colors")
AccessorFunc(PANEL, "m_color", "Color")



function PANEL:Init()
	self:SetColors({})

	self:SetColor(Color(211, 47, 47))

	self.smoothColor = self:GetColor()

	self.smoothRadius = 0
end

function PANEL:UpdateConVar(str)
	if not self.m_strConVar then return end

    RunConsoleCommand(self.m_strConVar, str)
end

function PANEL:SetColor(color)
	self.m_color = ColorAlpha(color, 255)

    local convarStr = color.r .. "," .. color.g .. "," .. color.b .. "," .. color.a
    self:UpdateConVar(convarStr)
end

function PANEL:SetValue(str)
	self.m_color = ColorAlpha(PatternKeypad.parseColor(str), 255)
end


function PANEL:Think()
    self:ConVarStringThink()


	if self.Hovered ~= self.oldHovered and self.Hovered == true then
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	self.oldHovered = self.Hovered
end

function PANEL:PerformLayout(w, h)
	local x, y = self:GetPos()
end

function PANEL:OnMousePressed()
    if self:GetDisabled() then return end

    self:MouseCapture(true)
    self.Depressed = true
    self:InvalidateLayout(true)

	self.shouldExpand = not IsValid(self.colorPanel)
end

function PANEL:OnMouseReleased(mouseCode)
    self:MouseCapture(false)

    if self:GetDisabled() then return end
    if not self.Depressed then return end

    self.Depressed = nil

    if not self.Hovered then return end

    self.Depressed = true

    if mouseCode == MOUSE_LEFT then
        self:DoClick()
    end

    self.Depressed = nil
end

function PANEL:OnDepressed() end

function PANEL:DoClick()
	if IsValid(self.colorPanel) then return end
	if not self.shouldExpand then return end

	local w, h = self:GetSize()
	local x, y = self:LocalToScreen(w / 2, h)

	local pnlW, pnlH = 3 * 32 + 4 * 2 + 16 + 4 + 4, 3 * 32 + 4 * 2 + 16
	self.colorPanel = openColorPanel(x - pnlW / 2, y + 10, pnlW, pnlH, self)

	for k, v in pairs(self:GetColors()) do
		local col = v
		if type(col) == "string" then
			col = PatternKeypad.hex2rgb(col)
		end

		self.colorPanel:AddColor(col)
	end

	self.colorPanel.OnColorClicked = function(pnl, colorPnl, color)
		local old = self:GetColor()
		self:SetColor(color)
		self:OnColorChanged(old, color)

		surface.PlaySound("buttons/button14.wav")

		closeColorPanels()
	end
end

function PANEL:OnColorChanged(oldColor, newColor) end -- for override

function PANEL:OnRemove()
	if IsValid(self.colorPanel) then
		self.colorPanel:Remove()
	end
end

function PANEL:Paint(w, h)
	PatternKeypad.lerpColor(self.smoothColor, self:GetColor(), 12 * FrameTime())

	local offset = self.Hovered and 0 or 3
	self.smoothRadius = self.smoothRadius + ((w / 2 - offset) - self.smoothRadius) * 12 * FrameTime()

    draw.NoTexture()
    PatternKeypad.drawCircle(w / 2, h / 2, self.smoothRadius, 20, self.smoothColor)
end

vgui.Register("DPatternKeypadColorSelector", PANEL, "Panel")

--------------------
-- Expanded panel --
--------------------
local PANEL = {}

AccessorFunc(PANEL, "m_color", "Color")
AccessorFunc(PANEL, "m_animTime", "AnimationTime")

function PANEL:Init()
	self.m_bIsColorPanel = true
	self.m_animTime = 0.1

	self.scroll = vgui.Create("DScrollPanel", self)
	self.scroll:Dock(FILL)
	self.scroll:DockMargin(8, 8, 8, 8)
	self.scroll.VBar:SetWide(4)

	self.scroll.VBar.btnGrip.Paint = function(pnl, w, h)
		surface_SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)
	end

	self.scroll.VBar.Paint = function(pnl, w, h) end

	self.scroll.VBar.btnUp:SetVisible(false)
	self.scroll.VBar.btnDown:SetVisible(false)


	-- Smooth scrolling
    self.scroll.scrollDelta = 0

    self.scroll.Think = function(panel)
        if panel.scrollDelta > 0 then
            panel.VBar:OnMouseWheeled(panel.scrollDelta / 8)

            panel.scrollDelta = panel.scrollDelta - 0.2
            if panel.scrollDelta < 0 then panel.scrollDelta = 0 end
        elseif panel.scrollDelta < 0 then
            panel.VBar:OnMouseWheeled(panel.scrollDelta / 8)

            panel.scrollDelta = panel.scrollDelta + 0.2
            if panel.scrollDelta > 0 then panel.scrollDelta = 0 end
        end

    end
    self.scroll.OnMouseWheeled = function(panel, delta)
        panel.scrollDelta = delta
    end

	--

	self.grid = vgui.Create("DIconLayout", self.scroll)
	self.grid:SetSpaceX(4)
	self.grid:SetSpaceY(4)
	self.grid:Dock(FILL)

end

function PANEL:Think()
	if IsValid(self.m_parent) then
		self:SetPos(self.m_parent:LocalToScreen(self.m_parentLocalX, self.m_parentLocalY))
	end
end

function PANEL:OnColorClicked(pnl, color) end

function PANEL:AddColor(color)
	local icon = self.grid:Add("DPatternKeypadColorEntry")
	icon:SetSize(32, 32)
	icon:SetColor(color)

	icon.DoClick = function(pnl) self:OnColorClicked(pnl, pnl:GetColor()) end
end

function PANEL:Close()
	local x, y = self:GetPos()
	self:SetAlpha(255)
	self:AlphaTo(0, self:GetAnimationTime())
	self:MoveTo(x, y - 10, self:GetAnimationTime())
	self:MoveToFront()

	timer.Simple(self:GetAnimationTime(), function()
		if IsValid(self) then self:Remove() end
	end)
end

function PANEL:Paint(w, h)
	draw.RoundedBox(8, 0, 0, w, h, Color(252, 252, 252))
end

vgui.Register("DPatternKeypadColorExpandedPanel", PANEL, "Panel")



-----------------
-- Color entry --
-----------------
local PANEL = {}

AccessorFunc(PANEL, "m_color", "Color")
AccessorFunc(PANEL, "m_bDisabled", "Disabled", FORCE_BOOL)

function PANEL:Init()
	self:SetColor(Color(255, 0, 0))

	self.smoothRadius = 0
end

function PANEL:OnMousePressed()
    if self:GetDisabled() then return end

    self:MouseCapture(true)
    self.Depressed = true
    self:InvalidateLayout(true)

	self.shouldExpand = not IsValid(self.colorPanel)
end

function PANEL:OnMouseReleased(mouseCode)
    self:MouseCapture(false)

    if self:GetDisabled() then return end
    if not self.Depressed then return end

    self.Depressed = nil

    if not self.Hovered then return end

    self.Depressed = true

    if mouseCode == MOUSE_LEFT then
        self:DoClick()
    end

    self.Depressed = nil
end

function PANEL:DoClick() end -- For override

function PANEL:Think()
	if self.Hovered ~= self.oldHovered and self.Hovered == true then
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	self.oldHovered = self.Hovered
end

function PANEL:Paint(w, h)
	local offset = self.Hovered and 0 or 3
	self.smoothRadius = self.smoothRadius + ((w / 2 - offset) - self.smoothRadius) * 15 * FrameTime()

    draw.NoTexture()
    PatternKeypad.drawCircle(w / 2, h / 2, self.smoothRadius, 20, self:GetColor())
end

vgui.Register("DPatternKeypadColorEntry", PANEL, "Panel")

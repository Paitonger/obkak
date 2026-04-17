-- t.me/urbanichka

local surface_SetDrawColor = surface.SetDrawColor

local PANEL = {}

Derma_Install_Convar_Functions(PANEL)

AccessorFunc(PANEL, "m_Combination", "Combination")
AccessorFunc(PANEL, "gridWidth", "GridWidth")
AccessorFunc(PANEL, "gridHeight", "GridHeight")

function PANEL:Init()
    self.grid = {}
    self.gridWidth = 3
    self.gridHeight = 3

    self.path = {}
    self.combination = {}

    self.circleRadiusHover = 24
    self.circleRadiusChecked = 32
    self.circleRadius = 16

    self.colPrimary = Color(69, 90, 100)
    self.colSecondary = Color(211, 47, 47)

    for x = 1, self.gridWidth do
        for y = 1, self.gridHeight do
            self.grid[x + y * self.gridWidth] = {
                radius = 0,
                color = Color(0, 0, 0, 80),
                x = 0,
                y = 0,
            }
        end
    end

    self.sliderWidth = vgui.Create("DNumSlider", self)
    self.sliderWidth:SetPos(10, 10)
    self.sliderWidth:SetText(PatternKeypad.language.toolGridColumns)
    self.sliderWidth:SetMin(2)
    self.sliderWidth:SetMax(4)
    self.sliderWidth:SetValue(self.gridWidth)
    self.sliderWidth:SetDecimals(0)
    self.sliderWidth.Label:SetTextColor(Color(0, 0, 0))

    self.sliderWidth.OnValueChanged = function(pnl, v)
        local new = math.Round(v)
        if self:GetGridWidth() == new then return end

        self:SetGridWidth(new)
        self:SetCombination({})
        self:UpdateGrid(true)
        self:UpdatePath()
    end

    self.sliderHeight = vgui.Create("DNumSlider", self)
    self.sliderHeight:SetPos(10, 30)
    self.sliderHeight:SetText(PatternKeypad.language.toolGridRows)
    self.sliderHeight:SetMin(2)
    self.sliderHeight:SetMax(4)
    self.sliderHeight:SetValue(self.gridHeight)
    self.sliderHeight:SetDecimals(0)
    self.sliderHeight.Label:SetTextColor(Color(0, 0, 0))

    self.sliderHeight.OnValueChanged = function(pnl, v)
        local new = math.Round(v)
        if self:GetGridHeight() == new then return end

        self:SetGridHeight(new)
        self:SetCombination({})
        self:UpdateGrid(true)
        self:UpdatePath()
    end

end

function PANEL:UpdateGrid(noUpdateSliders)
    local w, h = self:GetSize()

    local offsetX = w / (self.gridWidth + 1)
    local offsetY = w / (self.gridHeight + 1)

    for x = 1, self.gridWidth do
        for y = 1, self.gridHeight do
            local entry = self.grid[x + y * self.gridWidth]
            if not entry then
                entry = {
                    radius = 0,
                    color = Color(0, 0, 0, 80),
                    x = 0,
                    y = 0,
                }
                self.grid[x + y * self.gridWidth] = entry
            end

            entry.x = offsetX * x
            entry.y = h - offsetY * self.gridHeight + (y - 1) * offsetY + 10
        end
    end

    if not noUpdateSliders then
        self.sliderWidth:SetValue(self.gridWidth)
        self.sliderHeight:SetValue(self.gridHeight)
    end
end

function PANEL:PerformLayout(w, h)
    self:SetTall(w + 40)
    self.sliderWidth:SetWide(w - 20)
    self.sliderHeight:SetWide(w - 20)

    self:UpdateGrid()
end

function PANEL:ClearPath()
    for i = 1, #self.path do
        self.grid[self.path[i].id].checked = false
    end
    self.path = {}
end

function PANEL:UpdateConVar(str)
    RunConsoleCommand(self.m_strConVar, str)
end


function PANEL:SetCombination(combination)
    self.m_Combination = combination

    local comboStr = ""
    for i = 1, #combination do
        comboStr = comboStr .. (combination[i] - self.gridWidth)
        if i ~= #combination then
            comboStr = comboStr .. ","
        end
    end
    local convarStr = self.gridWidth .. "," .. self.gridHeight .. ":" .. comboStr

    self:UpdateConVar(convarStr)
end

function PANEL:UpdatePath()
    local oldPath = self.path
    self:ClearPath()

    for i = 1, #self:GetCombination() do
        local id = self:GetCombination()[i]
        local time = oldPath[i] and oldPath[i].time or 0

        self.path[i] = {
            id = id,
            time = time
        }

        self.grid[id].checked = true
    end
end

function PANEL:SetValue(value)
    if value == "" then return end

    self.gridWidth, self.gridHeight, self.m_Combination = PatternKeypad.parseCombination(value)

    self:UpdateGrid()
    self:UpdatePath()
end


function PANEL:Think()
    self:ConVarStringThink()

    if input.IsMouseDown(MOUSE_LEFT) then
        if not self.oldClick then self.firstHover = true end

        for cx = 1, self.gridWidth do
            for cy = 1, self.gridHeight do
                local entry = self.grid[cx + cy * self.gridWidth]

                if entry.hovered then
                    if self.firstHover then
                        self:ClearPath()
                        self.firstHover = false
                    end

                    if not entry.checked then
                        surface.PlaySound(PatternKeypad.soundClick)

                        self.path[#self.path + 1] = {
                            id = cx + cy * self.gridWidth,
                            time = 0,
                        }
                    end

                    entry.checked = true
                end
            end
        end
    else
        if #self.path > 0 and self.oldClick then
            if #self.path == 1 then
                self:ClearPath()
            else
                local combination = {}

                for i = 1, #self.path do
                    combination[#combination + 1] = self.path[i].id
                end

                if #combination > 1 then
                    self:SetCombination(combination)
                end
            end
        end
        self.firstHover = false
    end

    self.oldClick = input.IsMouseDown(MOUSE_LEFT)
end

function PANEL:Paint(w, h)
    local elapsed = FrameTime()

    draw.NoTexture()

    local cursorX, cursorY = self:LocalCursorPos()

    local wFract = w / 415
    local radiusChecked = self.circleRadiusChecked * wFract
    local radiusHover = self.circleRadiusHover * wFract
    local radius = self.circleRadius * wFract
    local lineWidth = 20 * wFract

    for i = 1, #self.path - 1 do
        local dat = self.path[i]
        dat.time = dat.time + (1 - dat.time) * 12 * elapsed

        local entry = self.grid[dat.id]
        local nextEntry = self.grid[self.path[i + 1].id]

        local dx = nextEntry.x - entry.x
        local dy = nextEntry.y - entry.y
        local ang = math.deg(math.atan2(-dy, dx))

        local mx = (nextEntry.x + entry.x) / 2
        local my = (nextEntry.y + entry.y) / 2
        local dist = math.sqrt(dx * dx + dy * dy)
        surface_SetDrawColor(ColorAlpha(self.colSecondary, dat.time * 255))
        surface.DrawTexturedRectRotated(mx, my, dist + 2, dat.time * lineWidth, ang)
    end

    for cx = 1, self.gridWidth do
        for cy = 1, self.gridHeight do
            local entry = self.grid[cx + cy * self.gridWidth]

            local dx = cursorX - entry.x
            local dy = cursorY - entry.y
            local dist = math.sqrt(dx * dx + dy * dy)

            local hovered = dist < radiusChecked
            if not entry.checked and not entry.hovered and hovered then
                surface.PlaySound(PatternKeypad.soundHover)
            end
            entry.hovered = hovered

            if entry.checked then
                entry.radius = entry.radius + (radiusChecked - entry.radius) * 12 * elapsed
                entry.color = PatternKeypad.lerpColor(entry.color, self.colSecondary, 12 * elapsed)
            else
                if hovered then
                    entry.radius = entry.radius + (radiusHover - entry.radius) * 12 * elapsed
                else
                    entry.radius = entry.radius + (radius - entry.radius) * 8 * elapsed
                end
                entry.color = PatternKeypad.lerpColor(entry.color, Color(0, 0, 0, 80), 12 * elapsed)
            end

            PatternKeypad.drawCircle(entry.x, entry.y, math.Round(entry.radius, 1), 16, entry.color)
        end
    end

    for i = 1, #self.path - 1 do
        local dat = self.path[i]

        local entry = self.grid[dat.id]
        local nextEntry = self.grid[self.path[i + 1].id]

        local dir = Vector(nextEntry.x - entry.x, nextEntry.y - entry.y, 0):GetNormalized()
        local perp = Vector(-dir.y, dir.x, 0)

        local sx = entry.x
        local sy = entry.y
        local sr = (entry.radius / 2) * dat.time
        local arrowWidth = dat.time * 10 * wFract

        local tbl = {
            { x = sx + dir.x * (sr + arrowWidth), y = sy + dir.y * (sr + arrowWidth) },
            { x = sx + dir.x * (sr - 3) + perp.x * arrowWidth, y = sy + dir.y * (sr - 3) + perp.y * arrowWidth },
            { x = sx + dir.x * (sr - 3) - perp.x * arrowWidth, y = sy + dir.y * (sr - 3) - perp.y * arrowWidth },
        }

        surface_SetDrawColor(Color(255, 255, 255, dat.time * 255))
        surface.DrawPoly(tbl)
    end
end

vgui.Register("DPatternKeypadGrid", PANEL, "Panel")

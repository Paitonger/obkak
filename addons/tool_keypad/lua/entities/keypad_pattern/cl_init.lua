-- t.me/urbanichka
include("shared.lua")

local function createFont(name, size)
    surface.CreateFont(name, {
        font = "Roboto",
        antialias = true,
        size = size,
        weight = 500,
    })
end

createFont("PatternKeypadWindow", 72)

local matWhite = CreateMaterial( "PatternKeypadMaterial", "UnlitGeneric", {
    ["$basetexture"] = "white",
    ["$vertexcolor"] = 1,
} )


local iconOpen = Material('icon16/door_in.png', 'smooth')
local iconSettings = Material('icon16/wrench.png', 'smooth')
local iconMoney = Material('icon16/money_dollar.png', 'smooth')

function ENT:Initialize()
    self:InitializeShared()

    local boxSize = self.boxMax - self.boxMin

    self.guiScale = 0.02
    self.guiWidth = math.floor(boxSize.y / self.guiScale)
    self.guiHeight = math.floor(boxSize.z / self.guiScale)

    self.guiPos = Vector(self.boxMax.x + 0.02, self.boxMin.y, self.boxMax.z)
    self.guiAng = Angle(0, 90, 90)

    self.guiWorldPos = Vector()
    self.guiWorldAng = Angle()

    self.colPrimary = Color(59, 73, 84)
    self.colSecondary = Color(211, 47, 47)
    self.colAccessGranted = Color(100, 255, 50)
    self.colAccessDenied = Color(255, 40, 20)

    self.circleRadiusHover = 24
    self.circleRadiusChecked = 32
    self.circleRadius = 16

    self.whitelistIDs = {}
    self.whitelistJobs = {}

    self.buttonsY = 134
    self.buttonHeight = 80
    self.space = 4

    self.confirmation = nil

    self.buttons = {
        {
            hovered = false,
            size = 64,
            icon = iconOpen,
            check = function()
                return self:CanOpen(LocalPlayer())
            end,
            doClick = function()
                RunConsoleCommand('keypad_open')
            end,
        },
        {
            hovered = false,
            size = 64,
            icon = iconSettings,
            check = function()
                return FPP.entGetOwner(self) == LocalPlayer()
            end,
            doClick = function()
                local menu = DermaMenu()

                menu:AddOption('Установить цену за вход', function()
                    Derma_StringRequest(
                        'Установить цену за проход',
                        'Укажи цену за использование этого кейпада\n(0 чтобы запретить проход за деньги)',
                        '0',
                        function(text)
                            RunConsoleCommand('keypad_setprice', text)
                        end
                    )
                end):SetIcon('icon16/money_dollar.png')

                menu:AddSpacer()

                -- ИГРОКИ

                local submenu, _submenu = menu:AddSubMenu('Игроки')
                _submenu:SetIcon('icon16/user.png')

                local add, _add = submenu:AddSubMenu('Добавить')
                _add:SetIcon('icon16/user_add.png')

                for _, v in ipairs(player.GetHumans()) do
                    if self.whitelistIDs[v:SteamID()] then continue end
                    add:AddOption(v:Name(), function()
                        RunConsoleCommand('keypad_add_steamid', v:SteamID())
                    end)
                end

                local delete, _delete = submenu:AddSubMenu('Удалить')
                _delete:SetIcon('icon16/user_delete.png')

                for k, _ in pairs(self.whitelistIDs) do
                    local pl = player.GetBySteamID(k)
                    if not IsValid(pl) then continue end

                    delete:AddOption(pl:Name(), function()
                        RunConsoleCommand('keypad_remove_steamid', k)
                    end)
                end

                -- ПРОФЫ

                local submenu, _submenu = menu:AddSubMenu('Профессии')
                _submenu:SetIcon('icon16/group.png')

                local add, _add = submenu:AddSubMenu('Добавить')
                _add:SetIcon('icon16/group_add.png')

                for k, v in pairs(RPExtraTeams) do
                    if self.whitelistJobs[k] then continue end
                    add:AddOption(v.name, function()
                        RunConsoleCommand('keypad_add_job', k)
                    end)
                end

                local delete, _delete = submenu:AddSubMenu('Удалить')
                _delete:SetIcon('icon16/group_delete.png')

                for k, _ in pairs(self.whitelistJobs) do
                    local job = RPExtraTeams[k]
                    if not job then continue end -- :flushed:
                    delete:AddOption(job.name, function()
                        RunConsoleCommand('keypad_remove_job', k)
                    end)
                end

                menu:Open()
                menu:Center()
            end,
        },
        {
            hovered = false,
            size = 64,
            icon = iconMoney,
            check = function()
                return self:GetPrice() ~= 0
            end,
            doClick = function()
                local price = self:GetPrice()
                if price > 15000 then
                    if IsValid(self.confirmation) then return end
                    self.confirmation = Derma_Query('Стоимость открытия этого кейпада - '..DarkRP.formatMoney(price)..'. Ты уверен?', 'Открыть кейпад', 'Открыть', function()
                        RunConsoleCommand('keypad_pay')
                    end, 'Отмена')
                else
                    RunConsoleCommand('keypad_pay')
                end
            end,
        },
    }
    
    self:CreateGrid()
end

net.Receive('keypad_pattern_sendwhitelist', function()
    local ent = net.ReadEntity()
    local ids = net.ReadTable()
    local jobs = net.ReadTable()

    if not IsValid(ent) then return end

    ent.whitelistIDs = ids
    ent.whitelistJobs = jobs
end)

function ENT:UpdateColors()
    local colorArr = string.Explode("-", self:GetColors())
    self.colPrimary = ColorAlpha(PatternKeypad.parseColor(colorArr[1]), 255)
    self.colSecondary = ColorAlpha(PatternKeypad.parseColor(colorArr[2]), 255)
    self.colAccessGranted = ColorAlpha(PatternKeypad.parseColor(colorArr[3]), 255)
    self.colAccessDenied = ColorAlpha(PatternKeypad.parseColor(colorArr[4]), 255)
end

function ENT:RefreshButtons()
    self.availableButtons = {}
    for _, v in ipairs(self.buttons) do
        if not v.check or v.check() ~= false then table.insert(self.availableButtons, v) end
    end
end

function ENT:CreateGrid()
    self.grid = {}
    self.path = {}

    local w, h = self.guiWidth, self.guiHeight
    local gridW, gridH = self:GetGridWidth(), self:GetGridHeight()

    local offsetX = w / (gridW + 1)
    local offsetY = w / (gridH + 1)
    local rad = 16

    for x = 1, gridW do
        for y = 1, gridH do
            local entry = self.grid[x + y * gridW]
            if not entry then
                entry = {
                    radius = 0,
                    color = Color(0, 0, 0, 80),
                    x = 0,
                    y = 0,
                }
                self.grid[x + y * gridW] = entry
            end

            entry.x = offsetX * x
            entry.y = h - offsetY * gridH + (y - 1) * offsetY
        end
    end
end

function ENT:GetCursorPosition()
    local rayVec = util.IntersectRayWithPlane(LocalPlayer():GetShootPos(), LocalPlayer():GetAimVector(), self.guiWorldPos, self.guiWorldAng:Up())
    if not rayVec then return 0, 0 end

    local dist = LocalPlayer():GetShootPos():Distance(rayVec)
    if dist > PatternKeypad.clickRange then return 0, 0 end

    local localRayVec = WorldToLocal(rayVec, Angle(), self.guiWorldPos, self.guiWorldAng)
    local boxSize = self.boxMax - self.boxMin

    local cursorFractX = localRayVec.x / boxSize.y
    local cursorFractY = -localRayVec.y / boxSize.z

    if cursorFractX < 0 or cursorFractX > 1 or cursorFractY < 0 or cursorFractY > 1 then
        return -1, -1
    end

    return cursorFractX * self.guiWidth, cursorFractY * self.guiHeight
end

function ENT:SendCombination(combination)
    net.Start("keypad_pattern_com")
        net.WriteEntity(self)
        net.WriteInt(#combination, 8)
        for i = 1, #combination do
            net.WriteInt(combination[i], 8)
        end
    net.SendToServer()
end

hook.Add('KeyPress', 'pattern_keypad_buttons', function(ply, key)
    if key ~= IN_USE then return end

    for _, v in pairs(ents.FindByClass('keypad_pattern')) do
        v.buttons = v.buttons or {}
        v:RefreshButtons()
    end

    for _, ent in ipairs(ents.FindByClass('keypad_pattern')) do
        if not IsValid(ent) then continue end
        for _, v in ipairs(ent.availableButtons) do
            if v.hovered then
                v.doClick()
                return
            end
        end
    end
end)

function ENT:Think()
    local lp = LocalPlayer()

    if lp:KeyDown(IN_USE) and self:GetStatus() == self.STATUS_NONE then
        local cursorX, cursorY = self:GetCursorPosition()
        local gridW, gridH = self:GetGridWidth(), self:GetGridHeight()

        for cx = 1, gridW do
            for cy = 1, gridH do
                local entry = self.grid[cx + cy * gridW]
                if not istable(entry) then return end
                if entry.hovered then
                    if not entry.checked then
                        surface.PlaySound(PatternKeypad.soundClick)

                        self.path[#self.path + 1] = {
                            id = cx + cy * gridW,
                            time = 0,
                        }
                    end

                    entry.checked = true
                end
            end
        end
    else
        if #self.path > 0 then
            local combination = {}

            for i = 1, #self.path do
                local dat = self.path[i]
                self.grid[dat.id].checked = false

                combination[#combination + 1] = dat.id
            end

            if #combination > 1 then
                self:SendCombination(combination)
            end

            self.path = {}
        end
    end


    local colorStr = self:GetColors()
    if colorStr ~= self.oldColorStr then
        self:UpdateColors()
    end
    self.oldColorStr = colorStr
end
local startTime = CurTime()
local startTime2 = CurTime()

function ENT:DrawOverlay()
    local lp = LocalPlayer()
    local elapsed = FrameTime()

    local w, h = self.guiWidth, self.guiHeight

    local cursorX, cursorY = self:GetCursorPosition()

    self.guiWorldPos = self:LocalToWorld(self.guiPos)
    self.guiWorldAng = self:LocalToWorldAngles(self.guiAng)
    cam.Start3D2D(self.guiWorldPos, self.guiWorldAng, self.guiScale)
        draw.NoTexture()

        surface.SetDrawColor(self.colPrimary)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 80))
        surface.DrawRect(40, 40, w - 80, 80)

        if self:GetStatus() == self.STATUS_GRANTED then
            draw.DrawText(PatternKeypad.language.textGranted, "PatternKeypadWindow", w / 2, 40, self.colAccessGranted, TEXT_ALIGN_CENTER)
        elseif self:GetStatus() == self.STATUS_DENIED then
            draw.DrawText(PatternKeypad.language.textDenied, "PatternKeypadWindow", w / 2, 40, self.colAccessDenied, TEXT_ALIGN_CENTER)
        elseif self:GetPrice() ~= 0 then
            draw.DrawText(DarkRP.formatMoney(self:GetPrice()), "PatternKeypadWindow", w / 2, 40, self.colAccessGranted, TEXT_ALIGN_CENTER)
        end

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
            surface.SetDrawColor(ColorAlpha(self.colSecondary, dat.time * 255))
            surface.DrawTexturedRectRotated(mx, my, dist, dat.time * 20, ang)
        end


        local gridW, gridH = self:GetGridWidth(), self:GetGridHeight()
        if #self.grid - gridW ~= gridW * gridH then
            self:CreateGrid()
        end

        for cx = 1, gridW do
            for cy = 1, gridH do
                local entry = self.grid[cx + cy * gridW]

                local dx = cursorX - entry.x
                local dy = cursorY - entry.y
                local dist = math.sqrt(dx * dx + dy * dy)

                local hovered = dist < self.circleRadiusChecked
                if not entry.checked and not entry.hovered and hovered then
                    surface.PlaySound(PatternKeypad.soundHover)
                end
                entry.hovered = hovered

                if entry.checked then
                    entry.radius = entry.radius + (self.circleRadiusChecked - entry.radius) * 12 * elapsed
                    entry.color = PatternKeypad.lerpColor(entry.color, self.colSecondary, 12 * elapsed)
                else
                    if hovered then
                        entry.radius = entry.radius + (self.circleRadiusHover - entry.radius) * 12 * elapsed
                    else
                        entry.radius = entry.radius + (self.circleRadius - entry.radius) * 8 * elapsed
                    end
                    entry.color = PatternKeypad.lerpColor(entry.color, Color(0, 0, 0, 80), 12 * elapsed)
                end

                PatternKeypad.drawCircle(entry.x, entry.y, entry.radius, 24, entry.color)
            end
        end

        self:RefreshButtons()
        for i, v in ipairs(self.availableButtons) do

            local bgW = (self.guiWidth - 80) / #self.availableButtons - math.floor(#self.availableButtons/2) * self.space
            local bgH = self.buttonHeight

            local x = (40 + bgW * i) - bgW/2 - v.size / 2 + self.space * (i-1)
            local y = self.buttonsY

            local dx = cursorX - (x + v.size/2)
            local dy = cursorY - (y + v.size/2)
            local dist = math.sqrt(dx * dx + dy * dy)

            local hovered = dist < v.size/2
            if not v.hovered and hovered then
                surface.PlaySound(PatternKeypad.soundHover)
            end
            v.hovered = hovered

            surface.SetDrawColor(Color(0, 0, 0, 80))
            surface.DrawRect((x + v.size/2) - bgW/2, y + v.size/2 - bgH/2, bgW, bgH)

            surface.SetMaterial(v.icon)
            surface.SetDrawColor(Color(255, 255, 255))
            if hovered then
                surface.DrawTexturedRect(x - 4, y - 4, v.size + 8, v.size + 8)
            else
                surface.DrawTexturedRect(x, y, v.size, v.size)
            end
        end

    cam.End3D2D()
end

function ENT:Draw()
    render.SuppressEngineLighting(true)
    render.SetMaterial(matWhite)
    render.DrawBox(self:GetPos(), self:GetAngles(), self.boxMin, self.boxMax, self.colPrimary, false)

    local lp = LocalPlayer()

    local dist = LocalPlayer():GetPos():Distance(self:GetPos())
    if dist > 150 then
        render.SuppressEngineLighting(false)
        surface.SetAlphaMultiplier(1)
        return
    end

    surface.SetAlphaMultiplier(1 - math.Clamp((dist - 125) / 25, 0, 1))

    local dot = (lp:GetShootPos() - self:GetPos()):Dot(self:GetForward())
    if dot > 0 then
        self:DrawOverlay()
    end
    render.SuppressEngineLighting(false)
    surface.SetAlphaMultiplier(1)
end





-- These functions are only here so no errors occur when used with willox's keypad,
-- because this addon aims to be compatible with the keypad cracker.
function ENT:GetHoveredElement()
end

function ENT:SendCommand()
end
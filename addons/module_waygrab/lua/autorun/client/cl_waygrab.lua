-- t.me/urbanichka
local capturing = false
local screenshotRequested = false
local screenshotFailed = false
local stopScreenGrab = false
local inFrame = false
local screenshotRequestedLastFrame = false
local split = 20000
local screengrabParts = {}
local frame = {}
local shouldSaveScreengrab = false
 
hook.Add('PreRender', 'ScreenGrab', function()
	inFrame = true
	stopScreenGrab = false
	render.SetRenderTarget()
end)
 
local screengrabRT = GetRenderTarget('ScreengrabRT' .. ScrW() .. '_' .. ScrH(), ScrW(), ScrH())
 
hook.Add('PostRender', 'ScreenGrab', function(vOrigin, vAngle, vFOV)
	if stopScreenGrab then return end
	inFrame = false
 
	if screenshotRequestedLastFrame then
		render.PushRenderTarget(screengrabRT)
	else
		render.CopyRenderTargetToTexture(screengrabRT)
		render.SetRenderTarget(screengrabRT)
	end
 
	if screenshotRequested or screenshotRequestedLastFrame then
        local selfScreengrabParts = {}
		screenshotRequested = false
 
		if jit.version == 'LuaJIT 2.1.0-beta3' then
			if screenshotRequestedLastFrame then
				screenshotRequestedLastFrame = false
			else
				screenshotRequestedLastFrame = true
			    return
            end
		end

        cam.Start2D()
			surface.SetFont('Trebuchet24')
			local text = LocalPlayer():SteamID()
			local x, y = ScrW() * 0.5, ScrH() * 0.5
			local w, h = surface.GetTextSize(text)
 
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(x - w * 0.5 - 5, y - h * 0.5 - 5, w + 10, h + 10)
 
			surface.SetTextPos(math.ceil(x - w * 0.5 ), math.ceil(y - h * 0.5))
			surface.SetTextColor(255, 255, 255)
			surface.DrawText(text)
 
			surface.SetDrawColor(255, 255, 255)
			surface.DrawRect(0, 0, 1, 1)
		cam.End2D()

		render.CapturePixels()
		local r, g, b = render.ReadPixel( 0, 0 )
		if r != 255 or g != 255 or b != 255 then
			net.Start('waygrab.failed')
				net.WriteString('Попытка подделки скриншота. (1)')
			net.SendToServer()
			return
		end
 
		capturing = true
		local frame1 = FrameNumber()
		local data = render.Capture({
			format = 'jpeg',
			quality = 35,
			x = 0,
			y = 0,
			w = ScrW(),
			h = ScrH()
		})
		local frame2 = FrameNumber()
		capturing = false
 
		if frame1 ~= frame2 then
			net.Start('waygrab.failed')
				net.WriteString('Попытка подделки скриншота. (2)')
			net.SendToServer()
			return
		end

        local base = util.Compress(util.Base64Encode(data))
        local len = base:len()

        local parts = math.ceil(len/split)

        for i = 1, parts do
            local min
            local max
            if i == 1 then
                min = i
                max = split
            elseif i > 1 and i ~= parts then
                min = (i - 1) * split + 1
                max = min + split - 1
            elseif i > 1 and i == parts then
                min = (i - 1) * split + 1
                max = len
            end
            local str = string.sub(base, min, max)
            selfScreengrabParts[i] = str
        end

        local i = 1
        timer.Create('waygrab.sendParts', .1, #selfScreengrabParts, function()
            local part = selfScreengrabParts[i]

            net.Start('waygrab.sendPart')
            net.WriteUInt(part:len(), 32)
            net.WriteData(part, part:len())
            net.SendToServer()

            if i == #selfScreengrabParts then
                timer.Simple(.1, function()
                    net.Start('waygrab.success')
                    net.SendToServer()
                end)
            end

            i = i + 1
        end)
	end
 
	if screenshotRequestedLastFrame then
		render.PopRenderTarget()
		render.CopyRenderTargetToTexture(screengrabRT)
		render.SetRenderTarget(screengrabRT)
	end
end)

net.Receive('waygrab.sendPart', function()
    local len = net.ReadUInt(32)
    local data = net.ReadData(len)

    table.insert(screengrabParts, data)
end)
 
hook.Add('PreDrawViewModel', 'ScreenGrab', function()
	if capturing then
		net.Start('waygrab.failed')
			net.WriteString('Попытка подделки скриншота. (3)')
		net.SendToServer()
		screenshotFailed = true
	end
end)

local function displayData(str, name)
    local main = vgui.Create('DFrame', vgui.GetWorldPanel())
    main:SetPos(0, 0)
    main:SetSize(ScrW(), ScrH())
    main:SetTitle(name or 'Скринграб')
    main:MakePopup()

    local html = vgui.Create('HTML', main)
    html:DockMargin(0, 0, 0, 0)
    html:Dock(FILL)
    html:SetHTML([[ <img width="]] .. ScrW() .. [[" height="]] .. ScrH() .. [[" src="data:image/jpeg;base64, ]] .. str .. [["/> ]])
end
 
net.Receive('waygrab.start', function()
	screenshotRequested = true
end)
 
net.Receive('waygrab.success', function()
    local finalData = util.Decompress(table.concat(screengrabParts))

    if shouldSaveScreengrab then
        if not file.Exists('waygrabs', 'DATA') then
            file.CreateDir('waygrabs')
        end
        file.Write('waygrabs/'..net.ReadString()..'_'..os.date('%H-%M_%d-%m-%Y')..'.txt', finalData)
    end

    displayData(finalData, net.ReadString())

    screengrabParts = {}
    shouldSaveScreengrab = false
end)
 
hook.Add('ShutDown', 'waygrab.stop', function()
	stopScreenGrab = true
	render.SetRenderTarget()
end)
 
hook.Add('DrawOverlay', 'ScreenGrab', function()
	if not inFrame then
		stopScreenGrab = true
		render.SetRenderTarget()
	end
end)

local canScreengrab = {
    ['Curator'] = true,
    ['Patron'] = true,
    ['Helper'] = true,
    ['+Helper'] = true,
    ['moder'] = true,
    ['admin'] = true,
    ['Trusted'] = true,
    ['WayZer Team'] = true,
    ['superadmin'] = true,
}

local function openFrame()
    if not canScreengrab[LocalPlayer():GetUserGroup()] then return LocalPlayer():ChatPrint('No Access') end

    frame.main = vgui.Create('DFrame')
    frame.main:SetSize(600, 250)
    frame.main:SetTitle('Скринграб')
    frame.main:SetIcon('icon16/camera.png')
    frame.main:MakePopup()
    frame.main.Paint = function(s,w,h)
        draw.RoundedBox(4,0,0,w,h,Color(54,57,62))
    end

    frame.savedPnl = vgui.Create('DPanel', frame.main)
    frame.savedPnl:Dock(LEFT)
    frame.savedPnl:SetPaintBackground(false)
    frame.savedPnl:SetWide(frame.main:GetWide()*0.35)

    frame.openSaved = vgui.Create('DButton', frame.savedPnl)
    frame.openSaved:Dock(BOTTOM)
    frame.openSaved:SetText('Открыть')

    frame.saved = vgui.Create('DListView', frame.savedPnl)
    frame.saved:Dock(FILL)
    frame.saved:AddColumn('Название')
    frame.saved:SetMultiSelect(false)
    for _, v in pairs(file.Find('waygrabs/*.txt', 'DATA')) do
        frame.saved:AddLine(v)
    end

    frame.openSaved.DoClick = function()
        local id = frame.saved:GetSelectedLine()
        if not id then return notification.AddLegacy('Ты не выбрал сохранение', 1, 3) end

        local line = frame.saved:GetLine(id)
        local name = line:GetColumnText(1)
        local data = file.Read('waygrabs/'..name, 'DATA')
        displayData(data, name)
    end

    frame.players = vgui.Create('DComboBox', frame.main)
    frame.players:Dock(TOP)
    frame.players:SetValue('Выбери игрока')
    frame.players:SetTall(25)
    for _, v in ipairs(player.GetHumans()) do
        frame.players:AddChoice(v:Name(), v:SteamID())
    end

    frame.shouldSave = vgui.Create('DCheckBoxLabel', frame.main)
    frame.shouldSave:Dock(TOP)
    frame.shouldSave:SetText('Сохранить файл')
    frame.shouldSave:DockMargin(0,8,0,0)
    frame.shouldSave.OnChange = function(val)
        shouldSaveScreengrab = val
    end

    frame.screengrab = vgui.Create('DButton', frame.main)
    frame.screengrab:Dock(TOP)
    frame.screengrab:SetText('Скринграбнуть')
    frame.screengrab:DockMargin(0,8,0,0)
    frame.screengrab:SetTall(25)

    frame.screengrab.DoClick = function()
        local sid = frame.players:GetOptionData(frame.players:GetSelectedID())
        if not sid then return notification.AddLegacy('Ты не выбрал игрока', 1, 3) end

        RunConsoleCommand('waygrab', sid)
        frame.main:Close()
    end

    frame.main:InvalidateLayout(true)
    frame.main:SizeToChildren(false, true)
    frame.main:Center()
end

concommand.Add('waygrab_menu', openFrame)

hook.Add('PostGamemodeLoaded', 'waygrab', function()
    FAdmin.ScoreBoard.Player:AddActionButton('Скринграб', 'icon16/camera.png', Color(0,140,255),
        function (ply) return canScreengrab[LocalPlayer():GetUserGroup()] end,
        function (ply)
            RunConsoleCommand('waygrab', ply:SteamID())
        end
    )
end)
-- t.me/urbanichka
local frame = {}

local function stripRefresh()
    if not IsValid(frame.strip) then return end

    frame.strip:Clear()
    frame.strip:SetValue(dEvents.getPhrase('vgui_preEvent_strip'))

    for _, v in pairs (dEvents.config.weaponPresets or {}) do
        frame.strip:AddChoice(v.name, v.weapons)
    end
    for _, v in pairs (dEvents.stripPresets or {}) do
        frame.strip:AddChoice(v.name, v.weapons)
    end
    frame.strip:AddChoice('Создать пресет', 'add', false, 'icon16/add.png')
    frame.strip:AddChoice('Удалить пресет', 'remove', false, 'icon16/cancel.png')
end

function dEvents.startMenu()
    local canStart, reason = dEvents.canStartEvent(LocalPlayer())
    if canStart == false then return notification.AddLegacy(reason or '', 1, 4) end

    if frame.main and IsValid(frame.main) then frame.main:Close() end
    frame.main = vgui.Create('DFrame')
    frame.main:SetSize(ScrW()*dEvents.config.startMenuSize.w, ScrH()*dEvents.config.startMenuSize.h)
    frame.main:SetPos(0,ScrH()/2 - frame.main:GetTall()/2)
    frame.main:SetIcon('icon16/bell.png')
    frame.main:SetTitle(dEvents.getPhrase('vgui_preEvent'))
    frame.main.Paint = function (s,w,h)
        draw.RoundedBox(0,0,0,w,h,dEvents.config.mainColor)
    end

    frame.start = vgui.Create('DButton', frame.main)
    frame.start:Dock(BOTTOM)
    frame.start:DockMargin(0,5,0,0)
    frame.start:SetText(dEvents.getPhrase('vgui_preEvent_start'))
    frame.start:SetIcon('icon16/accept.png')

    frame.tposes = {}

    frame.positions = vgui.Create('DButton', frame.main)
    frame.positions:Dock(BOTTOM)
    frame.positions:SetText(dEvents.getPhrase('vgui_preEvent_positions'))
    frame.positions:SetIcon('icon16/arrow_in.png')
    frame.positions.DoClick = function ()
        if #frame.tposes >= dEvents.config.maxPositions then return notification.AddLegacy(dEvents.getPhrase('error_maxPositions'), 1, 4) end

        table.insert(frame.tposes, LocalPlayer():GetPos())
        notification.AddLegacy(dEvents.getPhrase('hint_positionAdded', #frame.tposes), 0, 4)
    end

    frame.scroll = vgui.Create('DScrollPanel', frame.main)
    frame.scroll:Dock(FILL)

    frame.guide = vgui.Create('DLabel', frame.scroll)
    frame.guide:Dock(TOP)
    frame.guide:DockMargin(5,0,5,5)
    frame.guide:SetWrap(true)
    frame.guide:SetAutoStretchVertical(true)
    frame.guide:SetText(dEvents.getPhrase('vgui_preEvent_posGuide'))

    frame.startTime = vgui.Create('DNumSlider', frame.scroll)
    frame.startTime:Dock(TOP)
    frame.startTime:SetText(dEvents.getPhrase('vgui_preEvent_startTime'))
    frame.startTime:SetDecimals(0)
    frame.startTime:SetMinMax(dEvents.config.startTime.min, dEvents.config.startTime.max)
    frame.startTime:SetValue(dEvents.config.startTime.default)
    frame.startTime:DockMargin(5,0,5,5)
    
    frame.maxMembers = vgui.Create('DNumSlider', frame.scroll)
    frame.maxMembers:Dock(TOP)
    frame.maxMembers:SetText(dEvents.getPhrase('vgui_preEvent_maxMembers'))
    frame.maxMembers:SetDecimals(0)
    frame.maxMembers:SetMinMax(dEvents.config.maxMembers.min, dEvents.config.maxMembers.max)
    frame.maxMembers:SetValue(dEvents.config.maxMembers.default)
    frame.maxMembers:DockMargin(5,0,5,5)

    frame.strip = vgui.Create('DComboBox', frame.scroll)
    frame.strip:Dock(TOP)
    frame.strip:DockMargin(5,0,5,5)
    frame.strip:SetSortItems(false)
    stripRefresh()
    function frame.strip:OnSelect(id, val, data)
        if data == 'add' then
            local window = vgui.Create('DFrame')
            window:SetSize(ScrW()*dEvents.config.giveWeaponSize.w, ScrH()*dEvents.config.giveWeaponSize.h)
            window:SetTitle(dEvents.getPhrase('presetCreate'))
            window:MakePopup()
            window:Center()
            window.Paint = function (s,w,h)
                draw.RoundedBox(0,0,0,w,h,dEvents.config.mainColor)
            end

            local presetCreator = vgui.Create('devents_choosebrowser', window)
            presetCreator:Dock(FILL)
            presetCreator:AddColumn('Название')
            presetCreator:AddColumn('ClassName')
            
            local sweps = {}
            for class, name in pairs (dEvents.config.permittedWeapons) do
                table.insert(sweps, {name, class})
            end
            for _, v in pairs (weapons.GetList() or {}) do
                if dEvents.config.permittedCategories[v.Category] then
                    table.insert(sweps, {v.PrintName, v.ClassName})
                end
            end
            presetCreator:SetData(sweps)

            function presetCreator:Callback()
                Derma_StringRequest('Создание пресета', 'Введи название для пресета', '', function (name)
                    local len = utf8.len or utf8.length or string.len
                    if len(name) < 3 or len(name) > 20 then return notification.AddLegacy(dEvents.getPhrase('error_presetNameSize', 3, 20), 0, 4) end
                    
                    local selectedSweps = self:GetSelectedData()
                    local newPreset = {
                        name = tostring(name),
                        weapons = {},
                    }
    
                    for _, v in pairs (selectedSweps) do
                        table.insert(newPreset.weapons, v[2])
                    end

                    table.insert(dEvents.stripPresets, newPreset)
                    dEvents.writeStripPresets()

                    window:Close()
                    stripRefresh()
                end)
            end
        elseif data == 'remove' then
            local window = vgui.Create('DFrame')
            window:SetSize(ScrW()*0.2, ScrH()*0.15)
            window:SetTitle(dEvents.getPhrase('presetRemove'))
            window:MakePopup()
            window:Center()
            window.Paint = function (s,w,h)
                draw.RoundedBox(0,0,0,w,h,dEvents.config.mainColor)
            end

            local label = vgui.Create('DLabel', window)
            label:Dock(TOP)
            label:DockMargin(5,5,5,5)
            label:SetText(dEvents.getPhrase('vgui_presetRemove'))
            label:SetWrap(true)
            label:SetAutoStretchVertical(true)

            local combo = vgui.Create('DComboBox', window)
            combo:Dock(TOP)
            combo:DockMargin(5,0,5,0)
            for k, v in pairs (dEvents.stripPresets or {}) do
                combo:AddChoice(v.name, k)
            end
            
            local confirm = vgui.Create('DButton', window)
            confirm:Dock(BOTTOM)
            confirm:DockMargin(0,5,5,5)
            confirm:SetText('Удалить')
            confirm:SetIcon('icon16/cancel.png')
            function confirm:DoClick()
                table.remove(dEvents.stripPresets, combo:GetOptionData(combo:GetSelectedID()))
                dEvents.writeStripPresets()
                window:Close()
                stripRefresh()
            end
        end
    end

    frame.respawn = vgui.Create('DCheckBoxLabel', frame.scroll)
    frame.respawn:Dock(TOP)
    frame.respawn:SetText(dEvents.getPhrase('vgui_preEvent_respawn'))
    frame.respawn:DockMargin(5,5,5,5)

    function frame.start:DoClick()
        local chosenStrip = frame.strip:GetSelectedID()
        if not chosenStrip then return notification.AddLegacy(dEvents.getPhrase('error_stripNotChosen'), 1, 4) end
        if #frame.tposes == 0 then return notification.AddLegacy(dEvents.getPhrase('error_noPositions'), 1, 4) end

        local eventInfo = {
            startTime = frame.startTime:GetValue(),
            maxMembers = frame.maxMembers:GetValue(),
            strip = frame.strip:GetOptionData(chosenStrip),
            positions = frame.tposes,
            respawn = frame.respawn:GetChecked(),
        }

        net.Start('dEvents.initEvent')
        net.WriteTable(eventInfo)
        net.SendToServer()

        frame.main:Close()
    end
end

concommand.Add('eventpanel', dEvents.startMenu)

function dEvents.adminMenu()
    if not dEvents.config.superAdminGroups[LocalPlayer():GetUserGroup()] then return notification.AddLegacy(dEvents.getPhrase('error_notSAdmin'), 1, 4) end

    local window = vgui.Create('DFrame')
    window:SetSize(ScrW()*dEvents.config.adminMenuSize.w, ScrH()*dEvents.config.adminMenuSize.h)
    window:SetTitle('dEvents Admin')
    window:MakePopup()
    window:Center()
    window.Paint = function (s,w,h)
        draw.RoundedBox(0,0,0,w,h,dEvents.config.mainColor)
    end

    local events = vgui.Create('devents_admin', window)
    events:Dock(FILL)
end

concommand.Add('devents_admin', dEvents.adminMenu)
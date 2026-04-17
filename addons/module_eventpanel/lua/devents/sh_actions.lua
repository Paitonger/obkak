-- t.me/urbanichka
dEvents.actions = {}

--[[
    actionData:
        string icon - Иконка для команды
        string name - Название кнопки
        bool onePlayer - Такую команду можно будет использовать только на игроке
        bool noButton - У такой команды не будет кнопки
        function callback (table targets, table args)
        function panel (cmd, targets)
]]

function dEvents.addAction(command, data)
    dEvents.actions[string.lower(command)] = data
end

function dEvents.getSortedActions()
    local actions = {}
    for cmd, v in pairs (dEvents.actions) do
        local newAction = v
        newAction.command = cmd

        table.insert(actions, newAction)
    end
    table.sort(actions, function (a, b) return a.order < b.order end)
    return actions
end

-- Непосредственно добавляем действия

if CLIENT then
    function dEvents.floatSlider(title, text, name, decs, min, max, value, callback)
        local frame = vgui.Create('DFrame')
        frame:SetSize(400,200)
        frame:MakePopup()
        frame:Center()
        frame:SetTitle(title)
        frame.Paint = function(self, w, h)
            draw.RoundedBox(0,0,0,w,h,Color(54,57,62,255))	
        end
    
        local label = vgui.Create('DLabel', frame)
        label:Dock(TOP)
        label:DockMargin(0,5,0,5)
        label:SetText(text)
        label:SetWrap(true)
        label:SetAutoStretchVertical(true)
    
        local slider = vgui.Create('DNumSlider', frame)
        slider:Dock(TOP)
        slider:DockMargin(5,5,5,5)
        slider:SetText(name)
        slider:SetDecimals(decs)
        slider:SetMin(min)
        slider:SetMax(max)
        slider:SetValue(value)
    
        local button = vgui.Create('DButton', frame)
        button:Dock(BOTTOM)
        button:DockMargin(5,5,5,5)
        button:SetText('Готово')
        button:SetIcon('icon16/accept.png')
        button.DoClick = function ()
            callback(tonumber(slider:GetValue()))
            frame:Close()
        end
    end
end

dEvents.addAction('stop', {
    name = 'Закончить ивент',
    icon = 'icon16/cancel.png',
    order = 999999,
    noButton = true,
    callback = function (ply)
        dEvents.stopEvent(ply)
    end
})

dEvents.addAction('kick', {
    name = 'Кикнуть',
    icon = 'icon16/cancel.png',
    order = 1337,
    onePlayer = true,
    callback = function (ply, targets, args)
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            dEvents.removeEventMember(v)
            DarkRP.notify(v, 1, 4, dEvents.getPhrase('hint_kicked'))
        end
    end,
})

dEvents.addAction('sethp', {
    name = 'Выдать ХП',
    icon = 'icon16/heart.png',
    order = 10,
    callback = function (ply, targets, args)
        local hp = tonumber(args[2])
        hp = hp and hp >= dEvents.config.hp.min and hp <= dEvents.config.hp.max and hp or dEvents.config.hp.default
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            v:SetHealth(hp)
        end
    end,
    panel = function (cmd, targets)
        Derma_StringRequest('Выдать ХП', 'Введи ниже количество хп, которое хочешь выдать (Макс. '..dEvents.config.hp.max..')', '', function (hp)
            RunConsoleCommand('devents', cmd, targets, hp)
        end)
    end,
})

dEvents.addAction('setar', {
    name = 'Выдать броню',
    icon = 'icon16/shield.png',
    order = 20,
    callback = function (ply, targets, args)
        local armor = tonumber(args[2])
        armor = armor and armor >= dEvents.config.armor.min and armor <= dEvents.config.armor.max and armor or dEvents.config.armor.default
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            v:SetArmor(armor)
        end
    end,
    panel = function (cmd, targets)
        Derma_StringRequest('Выдать броню', 'Введи ниже количество брони, которое хочешь выдать (Макс. '..dEvents.config.armor.max..')', '', function (ar)
            RunConsoleCommand('devents', cmd, targets, ar)
        end)
    end,
})

dEvents.addAction('setspeed', {
    name = 'Установить скорость',
    icon = 'icon16/clock_go.png',
    order = 30,
    callback = function (ply, targets, args)
        local modifier = tonumber(args[2])
        modifier = modifier and modifier >= dEvents.config.speedScale.min and modifier <= dEvents.config.speedScale.max and modifier or dEvents.config.speedScale.default
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            print(modifier)
            v:SetWalkSpeed(160 * modifier)
            v:SetRunSpeed(240 * modifier)
        end
    end,
    panel = function (cmd, targets)
        dEvents.floatSlider('Установить скорость', 'Выбери ниже коэффицент скорости, которую ты хочешь установить', 'Коэффицент', 1, dEvents.config.speedScale.min, dEvents.config.speedScale.max, dEvents.config.speedScale.default, function (val)
            RunConsoleCommand('devents', cmd, targets, val)
        end)
    end,
})

dEvents.addAction('setjump', {
    name = 'Установить силу прыжка',
    icon = 'icon16/arrow_up.png',
    order = 40,
    callback = function (ply, targets, args)
        local power = tonumber(args[2])
        power = power and power >= dEvents.config.jumpScale.min and power <= dEvents.config.jumpScale.max and power or dEvents.config.jumpScale.default
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            v:SetJumpPower(200 * power)
        end
    end,
    panel = function (cmd, targets)
        dEvents.floatSlider('Установить силу прыжка', 'Выбери ниже коэффицент силы прыжка, которую ты хочешь установить', 'Коэффицент', 1, dEvents.config.jumpScale.min, dEvents.config.jumpScale.max, dEvents.config.jumpScale.default, function (val)
            RunConsoleCommand('devents', cmd, targets, val)
        end)
    end,
})

dEvents.addAction('setmodel', {
    name = 'Установить модель',
    icon = 'icon16/user_gray.png',
    order = 50,
    callback = function (ply, targets, args)
        local model = tostring(args[2])
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            v:SetModel(model)
        end
    end,
    panel = function (cmd, targets)
        Derma_StringRequest('Установить модель', 'Введи ниже название модели, которую хочешь установить', '', function (mdl)
            RunConsoleCommand('devents', cmd, targets, mdl)
        end)
    end,
})

dEvents.addAction('setscale', {
    name = 'Установить размер модели',
    icon = 'icon16/vector.png',
    order = 60,
    callback = function (ply, targets, args)
        local scale = tonumber(args[2])
        scale = scale and scale >= dEvents.config.modelScale.min and scale <= dEvents.config.modelScale.max and scale or dEvents.config.modelScale.default
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            v:SetModelScale(scale, 0)
            v:SetViewOffset(Vector(0, 0, 64) * scale)
            v:SetViewOffsetDucked(Vector(0, 0, 28) * scale)
        end
    end,
    panel = function (cmd, targets)
        dEvents.floatSlider('Установить размер модели', 'Выбери размер модели, который ты хочешь установить', 'Размер', 1, dEvents.config.modelScale.min, dEvents.config.modelScale.max, dEvents.config.modelScale.default, function (val)
            RunConsoleCommand('devents', cmd, targets, val)
        end)
    end,
})

dEvents.addAction('fullstrip', {
    name = 'Забрать все оружие',
    icon = 'icon16/gun.png',
    order = 70,
    callback = function (ply, targets, args)
        for _, v in pairs (targets) do
            if not IsValid(v) then return end
            v:StripWeapons()
        end
    end,
})

dEvents.addAction('giveweapon', {
    name = 'Выдать оружие',
    icon = 'icon16/gun.png',
    order = 80,
    panel = function (cmd, targets)
        local window = vgui.Create('DFrame')
        window:SetSize(ScrW()*dEvents.config.giveWeaponSize.w, ScrH()*dEvents.config.giveWeaponSize.h)
        window:SetTitle('Выдать оружие')
        window:MakePopup()
        window:Center()
        window.Paint = function (s,w,h)
            draw.RoundedBox(0,0,0,w,h,dEvents.config.mainColor)
        end

        local weapongive = vgui.Create('devents_choosebrowser', window)
        weapongive:Dock(FILL)
        weapongive:AddColumn('Название')
        weapongive:AddColumn('ClassName')
        
        local sweps = {}
        for class, name in pairs (dEvents.config.permittedWeapons) do
            table.insert(sweps, {name, class})
        end
        for _, v in pairs (weapons.GetList() or {}) do
            if dEvents.config.permittedCategories[v.Category] then
                table.insert(sweps, {v.PrintName, v.ClassName})
            end
        end
        weapongive:SetData(sweps)

        function weapongive:Callback()
            net.Start('dEvents.giveWeapon')
            net.WriteTable(self:GetSelectedData())
            net.WriteString(targets)
            net.SendToServer()
            window:Close()
        end
    end
})
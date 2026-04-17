-- t.me/urbanichka
dMarkers = {}

if CLIENT then
    dMarkers.markers = {}

    surface.CreateFont('dMarkers.title', {
        font = 'Arial Bold',
        extended = true,
        size = 22,
        weight = 300,
        antialias = true,
    })

    surface.CreateFont('dMarkers.text', {
        font = 'Arial Bold',
        extended = true,
        size = 18,
        weight = 300,
        antialias = true,
    })
    
    --[[
    surface.CreateFont('dMarkers.text.shadow', {
        font = 'Arial Bold',
        extended = true,
        size = 19,
        weight = 300,
        blursize = 5,
        antialias = true,
    })
    ]]

    hook.Add('Think', 'dMarkers.distance', function()
        local markers = dMarkers.markers
        for i = #markers, 1, -1 do
            local dist = math.floor((LocalPlayer():GetPos():DistToSqr(markers[i].pos)^(1/2))/50)
            if dist < 10 then
                dMarkers.remove(i)
            end
        end
    end)

    hook.Add('HUDPaint', 'dMarkers', function()
        local markers = dMarkers.markers
        for i, v in ipairs(markers) do
            local pos2D = v.pos:ToScreen()
            local x, y = math.floor(pos2D.x), math.floor(pos2D.y)
            local dist = math.floor((LocalPlayer():GetPos():DistToSqr(v.pos)^(1/2))/50)

            if v.icon then
                surface.SetMaterial(v.icon)
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(x - 16, y - 16, 32, 32)
            end

            local alpha = math.Clamp(350 - Vector(x,y,0):DistToSqr(Vector(ScrW()/2, ScrH()/2, 0)) / 100, 0, 255)
            if alpha > 0 then
                v.color.a = alpha
                local title = ('%s (%sм)'):format(v.title, dist)

                draw.SimpleTextOutlined(title, 'dMarkers.title', x, y + 35, v.color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0, v.color.a))
                
                --draw.DrawText(v.text, 'dMarkers.text.shadow', x, y + 50, Color(0,0,0, v.color.a), TEXT_ALIGN_CENTER)
                draw.DrawText(v.text, 'dMarkers.text', x, y + 50, Color(255,255,255, v.color.a), TEXT_ALIGN_CENTER)
            end
        end
    end)

    function dMarkers.create(d)
        -- Wrapping text
        local textArray = {}
        local cache = {}
        for k, v in ipairs(string.Explode(' ', d.text or '')) do
            table.insert(cache, v)
            if k % 8 == 0 then
                table.insert(textArray, table.concat(cache, ' '))
                cache = {}
            end
        end
        table.insert(textArray, table.concat(cache, ' '))

        d.text = table.concat(textArray, '\n')

        local id = table.insert(dMarkers.markers, {
            title = d.title,
            text = d.text,
            color = d.color,
            icon = d.icon and Material(d.icon) or nil,
            pos = d.pos,
            time = d.time,
            type = d.type,
        })

        -- Creating remove timer
        if d.time and d.time ~= 0 then
            timer.Simple(d.time, function ()
                dMarkers.remove(id)
            end)
        end
    end

    function dMarkers.remove(id)
        if not dMarkers.markers[id] then return end

        table.remove(dMarkers.markers, id)
    end

    function dMarkers.removeAll(type)
        for i = #dMarkers.markers, 1, -1 do
            if not type or dMarkers.markers[i].type == type then
                table.remove(dMarkers.markers, i)
            end
        end
    end

    net.Receive('dMarkers.create', function()
        local d = net.ReadTable()
        local sound = net.ReadString()

        dMarkers.create({
            title = d.title,
            text = d.text,
            color = d.color,
            icon = d.icon,
            pos = d.pos,
            time = d.time,
            type = d.type,
        })
        if sound then surface.PlaySound(sound) end
    end)

    concommand.Add('dmarkers_remove_police', function ()
        dMarkers.removeAll('police')
    end)
    --[[
    concommand.Add('dmarkers_benchmark', function()
        for i=1, 50 do
            dMarkers.create({
                title = 'Marker №'..i,
                text = 'Testing new dMarkers',
                color = Color(200, 0, 0),
                icon = 'icon16/user.png',
                pos = Vector(i * 150, 100, -12000),
                type = 'test'
            })
        end
    end)

    concommand.Add('dmarkers_benchmark_stop', function()
        dMarkers.removeAll('test')
    end)
    ]]
else
    util.AddNetworkString('dMarkers.create')

    function dMarkers.create(targets, data, sound)
        for _, v in pairs(istable(targets) and targets or {targets}) do
            net.Start('dMarkers.create')
            net.WriteTable(data)
            if sound then net.WriteString(sound) end
            net.Send(v)
        end
    end
end
-- t.me/urbanichka
util.AddNetworkString('waygrab.stop')
util.AddNetworkString('waygrab.failed')
util.AddNetworkString('waygrab.success')
util.AddNetworkString('waygrab.start')
util.AddNetworkString('waygrab.sendPart')

local function upload(data, name)
	HTTP({
		url = 'https://api.imgur.com/3/image',
		method = 'post',
		headers = {
			[ "Authorization" ] = 'Client-ID 68ac82050bb717f',
		},
        parameters = {
			image = data
		},
		success = function(_, body)
			if screenshotFailed then
				screenshotFailed = false
				return
			end
 
			body = util.JSONToTable(body)
			if not istable(body) then return end
            if not body.data.link and body.data.error then return end

            SendGroupADM(string.format('Скринграб игрока %s: %s', name or 'unknown', body.data.link))
		end,
	})
end

net.Receive('waygrab.sendPart', function(_, ply)
    if not ply.screengrabbers then return end
    if ply.screengrabTime < CurTime() then
        ply.screengrabbers = nil
        return
    end

    local len = net.ReadUInt(32)
    local data = net.ReadData(len)

    table.insert(ply.screengrabParts, data)
end)
 
net.Receive('waygrab.success', function(len, ply)
    if not ply.screengrabbers then return end

	if (ply.screengrabTime or math.huge) > CurTime() then
        local i = 1
        timer.Create('waygrab.sendParts_'..ply:SteamID64(), .1, #ply.screengrabParts, function()
            local part = ply.screengrabParts[i]

            for _, v in pairs(ply.screengrabbers) do
                if type(v) ~= 'string' and v:IsPlayer() then
                    net.Start('waygrab.sendpart')
                        net.WriteUInt(part:len(), 32)
                        net.WriteData(part, part:len())
                    net.Send(v)

                    if i == #ply.screengrabParts then
                        timer.Simple(.1, function()
                            net.Start('waygrab.success')
                            net.WriteString(ply:Name():gsub(' ', '-'))
                            net.Send(v)
                        end)
                    end

                elseif i == #ply.screengrabParts then
                    local finalData = util.Decompress(table.concat(ply.screengrabParts))
                    upload(finalData, ply:Name())
                end
            end

            if i == #ply.screengrabParts then
                ply.screengrabbers = nil
                ply.screengrabParts = nil
            end

            i = i + 1
        end)
	end
end)
 
net.Receive('waygrab.failed', function(len, ply)
	if not ply.screengrabbers then return end

    for _, v in pairs(ply.screengrabbers) do
        if type(v) ~= 'string' and v:IsPlayer() then
            v:ChatPrint('Произошла ошибка при скринграбе игрока ' .. ply:Name() .. '. ' .. net.ReadString())
        else
            SendGroupADM('Произошла ошибка при скринграбе игрока ' .. ply:Name() .. '. ' .. net.ReadString())
        end
    end

	ply.screengrabbers = nil
end)

hook.Add('PlayerDisconnected', 'waygrab', function(ply)
    for _, v in pairs(ply.screengrabbers or {}) do
        if type(v) ~= 'string' and v:IsPlayer() then
            v:ChatPrint('Игрок '..ply:Name()..' вышел с сервера до окончания скринграба')
        else
            SendGroupADM('Игрок '..ply:Name()..' вышел с сервера до окончания скринграба')
        end
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

local function screengrab(target, initiators, time)
    if not IsValid(target) then return end

    local plys = {}
    for i, v in ipairs(istable(initiators) and initiators or {initiators}) do
        plys[i] = v:IsPlayer() and v or 'console'
    end

    if target.screengrabbers and istable(target.screengrabbers) then
        table.Add(target.screengrabbers, plys)
    else
        target.screengrabbers = plys
        target.screengrabTime = CurTime() + (time or 60)
        target.screengrabParts = {}

        net.Start('waygrab.start')
        net.Send(target)
    end
end

concommand.Add('waygrab', function(ply, cmd, args)
    if ply:IsPlayer() then
        if not canScreengrab[ply:GetUserGroup()] then return ply:ChatPrint('No Access') end
        if ply.screengrabCooldown and ply.screengrabCooldown > CurTime() then return ply:ChatPrint('Подожди немного') end
    end

    local target = DarkRP.findPlayer(args[1])
    if not IsValid(target) then
        if ply:IsPlayer() then
            ply:ChatPrint('Цель не найдена')
        else
            SendGroupADM('Игрок для скринграба не найден')
        end
    end

    if ply:IsPlayer() then
        ply.screengrabCooldown = CurTime() + 15
        ply:ChatPrint('Начат скринграб игрока '..target:Name())
    else
        SendGroupADM('Начат скринграб игрока '..target:Name())
    end

    screengrab(target, ply)
end)
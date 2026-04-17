-- 17.04
local s = {
    url = 'http://wayzerroleplay.myarena.ru/php',
    guild = '275515018282532865',

    -- Префикс категории ("Префикс" Riverton)
    prefix = 'Logs - ',

    servers = {
        ['46.174.54.203:27015'] = 'Riverton',
        ['46.174.54.52:27015'] = 'Minton',
        ['37.230.228.180:27015'] = 'Carlin',
        ['62.122.213.48:27015'] = 'Brooks',
        ['37.230.162.208:27015'] = 'Rockford',
    },

    -- Разделы логов, которые не будут логироваться (lower-)
    ignored = {
        damage = true,
        nlr = true,
        props = true,
        tools = true,
    },
}

local category = nil
local channels = {}

local function getChannel(id, cb)
    HTTP({
        url = s.url..'/channel.php',
        method = 'GET',
        parameters = {
            id = id,
        },
        success = cb,
    })
end

local function getAllChannels(guild, cb)
    HTTP({
        url = s.url..'/channel.php',
        method = 'GET',
        parameters = {
            guild = guild,
        },
        success = cb,
    })
end

-- 0 - Текстовый, 4 - Категория
local function createChannel(name, guild, type, parent, cb)
    HTTP({
        url = s.url..'/channel.php',
        method = 'POST',
        parameters = {
            name = name,
            guild = guild,
            type = type,
            parent_id = parent,
        },
        success = cb,
    })
end

local function sendMessage(channel, text, embeds, cb)
    HTTP({
        url = s.url..'/message.php',
        method = 'POST',
        parameters = {
            channel = channel,
            content = text,
            embeds = util.TableToJSON(embeds),
        },
        success = cb,
    })
end

local function findChannel(data, name, type, parent)
    for _, v in ipairs(data) do
        if string.lower(v.name) == string.lower(name) then
            if not type or tonumber(v.type) == tonumber(type) then
                if not parent or tostring(parent) == tostring(v.parent_id) then return v end
            end
        end
    end

    return false
end

local function checkCategory()
    getAllChannels(s.guild, function(code, body)
        local res = util.JSONToTable(body)

        local catName = s.prefix..'Minton'
        
        local cat = findChannel(res, catName, '4')

        if not cat then
            createChannel(catName, s.guild, '4', nil, function(code, body)
                local res = util.JSONToTable(body)
                category = res.id
            end)
        else
            category = cat.id
        end
    end)
end

local function checkChannel(name, cb)
    name = string.lower(name)

    getAllChannels(s.guild, function(code, body)
        local res = util.JSONToTable(body)

        local channel = findChannel(res, name, 0, category)

        if not channel then
            createChannel(name, s.guild, '0', category, function(code, body)
                local res = util.JSONToTable(body)
                channels[name] = res.id

                if cb then cb(res) end
            end)
        else
            channels[name] = channel.id

            if cb then cb(channel) end
        end
    end)
end

local function getAvatar(sid, cb)
    HTTP({
        url = 'http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002',
        method = 'GET',
        parameters = {
            key = '2F7705B3EF5673695FE613EF27C9069F',
            steamids = tostring(sid),
        },
        success = function(code, body)
            local res = util.JSONToTable(body)
            
            if cb then cb(res) end
        end,
    })
end

local logsCache = {}

local function addCache(channel, embed)
    logsCache[channel] = logsCache[channel] or {}

    table.insert(logsCache[channel], embed)
end

timer.Create('DiscordLogs.constructMessages', 10, 0, function()
    for ch, v in pairs(logsCache) do
        local channel = channels[string.lower(ch)]
        if not channel then
            return checkChannel(ch)
        end

        local messages = {}

        local i = 0

        local msg = {}
        for _, embed in ipairs(v) do
            i = i + 1
            
            if i >= 10 then
                table.insert(messages, msg)
                msg = {}
                i = 0
            else
                table.insert(msg, embed)
            end
        end

        if #msg ~= 0 then table.insert(messages, msg) end

        for _, v in ipairs(messages) do
            sendMessage(channel, nil, v)
        end

        logsCache[ch] = {}
    end
end)

function DiscordLog(d)
    if s.ignored[d.channel:lower()] then return end

    local embed = {
        description = d.content,
        color = 15105570,
        timestamp = os.date('!%Y-%m-%dT%H:%M:%S', time),
        footer = {
            icon_url = IsValid(d.player) and d.player.steamavatar or 'https://sun9-45.userapi.com/impf/c830409/v830409301/1d85/HoAFiouZdRU.jpg?size=200x200&quality=96&sign=9293d4af692267026c987b2443e36645&type=album',
            text = IsValid(d.player) and ('%s | %s (%s) | %s'):format(d.player:Name(), d.player:SteamID(), d.player:UserID(), d.player:GetUserGroup()) or 'WayZer\'s Role Play',
        },
    }

    addCache(string.lower(d.channel), embed)
end

hook.Add('Think', 'DiscordLogs', function()
    hook.Remove('Think', 'DiscordLogs')
    checkCategory()
end)

hook.Add('PlayerAuthed', 'DiscordLogs.loadAvatar', function(ply)
    getAvatar(ply:SteamID64(), function(d)
        if not d.response then return end
        ply.steamavatar = d.response.players[1].avatarmedium
    end)
end)
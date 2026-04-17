-- 17.04
function dEvents.canStartEvent(ply)
    if not IsValid(ply) then return false, 'Ты не существуешь 0_o' end

    if not dEvents.config.adminGroups[ply:GetUserGroup()] then return false, dEvents.getPhrase('error_notEventer') end

    if SERVER then
        if dEvents.getEventer(ply) then return false, dEvents.getPhrase('error_inEvent') end
        if dEvents.getFreeEvents()[1] then return false, dEvents.getPhrase('error_eventPreparing') end
        if dEvents.getEventTable(ply) then return false, dEvents.getPhrase('error_eventFounder') end
    end
end

function dEvents.getPhrase(phrase, ...)
    local format = {...}
    return dEvents.lang[phrase] and string.format(dEvents.lang[phrase], unpack(format or {})) or ''
end

if SERVER then
    function dEvents.notify(ply, ...)
        local args = {...}
    
        net.Start('dEvents.notify')
        net.WriteTable(args)
        net.Send(ply)
    end

    function dEvents.notifyAll(...)
        local args = {...}
    
        net.Start('dEvents.notify')
        net.WriteTable(args)
        net.Broadcast()
    end
else
    net.Receive('dEvents.notify', function ()
        dEvents.notify(unpack(net.ReadTable()))
    end)
    function dEvents.notify(...)
        local args = table.Add({Color(0,158,0), '[EVENT] '}, {...})
        local newArgs = {}

        for _, v in pairs (args) do 
            local value = istable(v) and Color(v.r, v.g, v.b, v.a) or v
            table.insert(newArgs, value)
        end
        
        chat.AddText(unpack(newArgs))
    end
end
-- 17.04
dEvents.netStrings = {
    'dEvents.initEvent',
    'dEvents.getEventTable',
    'dEvents.notify',
    'dEvents.giveWeapon',
    'dEvents.getAllEvents',
    'dEvents.stopEvent',
}

for _, v in pairs (dEvents.netStrings) do
    util.AddNetworkString(v)
end

net.Receive('dEvents.initEvent', function (_, ply)
    local eventInfo = net.ReadTable() or {}

    dEvents.initEvent(ply, eventInfo)
end)

function dEvents.sendEventTable(ply)
    if not IsValid(ply) then return end

    local eventTable = dEvents.getEventTable(ply)

    net.Start('dEvents.getEventTable')
    net.WriteTable(eventTable or {})
    net.Send(ply)
end

net.Receive('dEvents.getEventTable', function (_, ply)
    dEvents.sendEventTable(ply)
end)

net.Receive('dEvents.getAllEvents', function (_, ply)
    if not dEvents.config.superAdminGroups[ply:GetUserGroup()] then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_notSAdmin')) end

    net.Start('dEvents.getAllEvents')
    net.WriteTable(dEvents.events)
    net.Send(ply)
end)

net.Receive('dEvents.stopEvent', function (_, ply)
    if not dEvents.config.superAdminGroups[ply:GetUserGroup()] then return DarkRP.notify(ply, 1, 4, dEvents.getPhrase('error_notSAdmin')) end

    dEvents.stopEvent(net.ReadString())
end)
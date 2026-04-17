-- t.me/urbanichka
FAdmin.Messages.RegisterNotification({
    name = "wayban_ban",
    hasTarget = false,
    message = {"instigator", " выдал перманентный бан ", "extraInfo.1", " (", "extraInfo.2", ')'},
    receivers = "everyone",
    writeExtraInfo = function(info)
        local Data = {}
        Data.steamid = info[1]
        Data.reason = info[2]
        net.WriteString(Data.steamid)
        net.WriteString(Data.reason)
    end,
    readExtraInfo = function()
        return {net.ReadString(), net.ReadString()}
    end,
    extraInfoColors = {Color(102, 0, 255), Color(255, 102, 0)}
})

FAdmin.Messages.RegisterNotification({
    name = "wayban_unban",
    hasTarget = false,
    message = {"instigator", " снял перманентный бан с ", "extraInfo.1"},
    receivers = "everyone",
    writeExtraInfo = function(info)
        local Data = {}
        Data.steamid = info[1]
        net.WriteString(Data.steamid)
    end,
    readExtraInfo = function()
        return {net.ReadString(), net.ReadString()}
    end,
    extraInfoColors = {Color(102, 0, 255), Color(255, 102, 0)}
})
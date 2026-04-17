-- 17.04

local usergroup = {
    "Eventer",
    "+Eventer",
	"Helper",
	"+Helper",
	"Curator",
	"moder",
	"admin",
	"Patron",
	"Trusted",
	"WayZer Team",
	"superadmin",
}

/*

util.AddNetworkString("sendnotification")
util.AddNetworkString("startevent")

net.Receive("startevent", function(len, ply)
	if not table.HasValue(usergroup, ply:GetUserGroup()) then return end

	local pos_one = net.ReadVector()
	local pos_two = net.ReadVector()
	local pos_thri = net.ReadVector()
	local time = net.ReadFloat()
	local weapon = net.ReadString()
	
	if weapon == nil then ply:ChatPrint("Что с пушками то делать? Дубина!") return end
	if pos_one == nil then ply:ChatPrint("Что ты там с позициями намутил!? Попробуй ещё раз!") return end
	
	local table_event = {
		[1] = pos_one,
		[2] = pos_two,
		[3] = pos_thri,
	}
	
    net.Start("sendnotification") -- WARNING
 	net.WriteString(tostring(ply:Name()))
 	net.WriteString(tostring(ply:SteamID()))
    net.Broadcast()
	
	concommand.Add("go", function(ply)
	  if weapon == "Ничего не делать" then
	    ply:SetPos(table_event[math.random(1,3)])
	  elseif weapon == "Забрать все оружие" then
	   	ply:StripWeapons()
	    ply:SetPos(table_event[math.random(1,3)])
	  else
	   	ply:StripWeapons()
	    ply:SetPos(table_event[math.random(1,3)])
	    ply:Give(weapon)
	  end
  end)
		
	timer.Simple(time, function()
		concommand.Remove("go")
	end)
	
end)

*/

util.AddNetworkString("size_me")

net.Receive("size_me", function(len, ply)
	if not table.HasValue(usergroup, ply:GetUserGroup()) then return end
		
	local value = net.ReadFloat(16)
	local size = math.Clamp(value, 0.70, 3.00)
	
	ply:SetModelScale(size)
    ply:SetViewOffset( Vector(0, 0, 64) * size )
    ply:SetViewOffsetDucked( Vector(0, 0, 28) * size )
	ply:ChatPrint("Твой размер установлен на "..size)
end)

util.AddNetworkString("setmodel_admin")

net.Receive("setmodel_admin", function(len, ply)
		if not table.HasValue(usergroup, ply:GetUserGroup()) then return end
    local model = net.ReadString()
    ply:SetModel(model)
    ply:ChatPrint("Ты установил себе модель "..model)
end)

util.AddNetworkString("send_banning")

net.Receive("send_banning",function(len, ply)
	if ply:GetUserGroup() == "superadmin" then
	  local pl = net.ReadString()
	  for k,v in pairs(player.GetAll()) do
	  	if v:Name() == pl then
	  		v:Ban(1440, true)
	  	end
	  end
	else
	   ply:ChatPrint("Пишов нахуй от моего кролика!") 
	end
end)

util.AddNetworkString("chatclear")
util.AddNetworkString("ClearPlayerChat")

net.Receive("chatclear", function(len, ply)
   if not table.HasValue(usergroup, ply:GetUserGroup()) then return end
   net.Start('ClearPlayerChat')
   net.Broadcast()
end)

-- t.me/urbanichka
util.AddNetworkString("SetRapeManyak")

util.AddNetworkString("ManyakSound")

net.Receive("SetRapeManyak", function(len,ply)
 if not IsValid(ply) then return end
 if ply:Team() ~= TEAM_MANUAK then ply:ChatPrint("Мамкин хуйкер, пиздуй отсюда!") end -- 209 - 213 (module_hotlinehud)
 if ply:GetNWInt("PTS") >= 50000 then
 if ply:GetNWInt("ManuakRAPE") then return end
    ply:SetModel("models/player/skeleton.mdl")
    ply:SetHealth(300)
    ply:SetArmor(100)
    net.Start("ManyakSound")
    net.Send(ply)
 	ply:SetNWBool("ManuakRAPE", true)
 end
end)
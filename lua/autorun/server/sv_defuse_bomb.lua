-- t.me/urbanichka
hook.Add("KeyPress", "defuse_bomb", function(ply, key)
   if not ply:isCP() then return end
   if key ~= IN_USE then return end
   local progress = 1
   local tr = ply:GetEyeTrace()
   if not IsValid(tr.Entity) then return end
   if tr.Entity:GetClass() ~= "ent_timebomb" then return end
   if tr.Entity:GetPos():Distance(ply:GetShootPos()) > 250 then return end 
   local timername = "trace_ent"..ply:SteamID()
   
   
   timer.Create(timername, 1, 0, function()
   	tr = ply:GetEyeTrace()
      if not IsValid(ply) then timer.Destroy(timername) return end
      if not ply:Alive() then timer.Destroy(timername) return end
      if not IsValid(tr.Entity) then timer.Destroy(timername) return end
      if tr.Entity:GetClass() ~= "ent_timebomb" then timer.Destroy(timername) return end
      if tr.Entity:GetPos():Distance(ply:GetShootPos()) > 250 then timer.Destroy(timername) return end
      DarkRP.notify(ply, 2, 3, "Деактивация бомбы.. ("..progress.."/10)")
      progress = progress + 1
      ply:EmitSound('npc/combine_soldier/gear'..math.random(1,6)..'.wav')
      if progress >= 11 then 
      	DarkRP.notify(ply, 0, 10, 'Бомба деактивирована!')
      	ply:EmitSound("buttons/button9.wav")
      	tr.Entity:Remove()
      	timer.Destroy(timername)
      	DarkRP.notifyAll(0, 30, ply:Nick()..' обезвредил бомбу и получил $10000')
      	ply:addMoney(10000)
      end
   end)
   
end)

hook.Add("KeyPress", "snowball_equip", function(ply, key)
	if key ~= IN_USE then return end
	local tr = ply:GetEyeTrace()
	if not IsValid(tr.Entity) then return end
	if tr.Entity:GetModel() ~= [[models\props/cs_militia/rockpileramp01.mdl]] then return end
	if tr.Entity:GetPos():Distance(ply:GetShootPos()) > 300 then return end 
	ply:Give("snowball_thrower_nodamage")
	ply:SelectWeapon("snowball_thrower_nodamage")
end)

hook.Add("KeyPress", "mayor_home", function(ply, key)
   if key ~= IN_USE then return end
   local tr = ply:GetEyeTrace()
   if not IsValid(tr.Entity) then return end
   if tr.Entity:GetModel() ~= "models/props/cs_italy/it_doorb.mdl" then return end
   if tr.Entity:GetPos():Distance(ply:GetShootPos()) > 100 then return end 
   if tr.Entity:GetModelScale() > 1 then
   tr.Entity:EmitSound('ambient/materials/footsteps_wood'..math.random(1,2)..'.wav')
   ply:SetPos(Vector(1968, 2414, 153))
   elseif tr.Entity:GetModelScale() < 1 then
   tr.Entity:EmitSound('ambient/materials/footsteps_wood'..math.random(1,2)..'.wav')
   ply:SetPos(Vector(1663, 2431, 221))
   end
end)
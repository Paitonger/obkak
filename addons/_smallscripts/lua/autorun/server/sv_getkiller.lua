-- 17.04
plogs.Register('NLR', false)

hook.Add("PlayerDeath", "CreateTryp", function(v,i,a)
  if not IsValid(a) then return end
	if v ~= a then
	    if not a:IsPlayer() then return end
		if IsValid(v:GetRagdollEntity()) then
			local deadRag = v:GetRagdollEntity()
			deadRag:Remove()
		end
		local ragdoll = ents.Create("prop_ragdoll")
		ragdoll:SetPos(v:GetPos())
		ragdoll:SetAngles(Angle(0,v:GetAngles().Yaw,0))
		ragdoll:SetModel(v:GetModel())
		ragdoll:Spawn()
		ragdoll:Activate()
		ragdoll:SetVelocity(v:GetVelocity())
		ragdoll:SetNWEntity("KillerRagdoll", a)
		ragdoll:SetNWEntity("Owner_ragdoll", v)
		ragdoll:SetCollisionGroup(20)
		timer.Simple(3, function()
		    if not IsValid(ragdoll) then return end
		    ragdoll:SetMoveType(MOVETYPE_NONE)
		end)
		timer.Simple(120, function() if not IsValid(ragdoll) then return end ragdoll:Remove() end)


		local timername = "CheckNLRSphere"..v:SteamID()
		
		timer.Create(timername, 10, 0, function()
			if not IsValid(v) then timer.Destroy(timername) return end
			if not IsValid(ragdoll) then timer.Destroy(timername) return end
			if v:Team() == TEAM_BANNED then timer.Destroy(timername) return end
			if v:Team() == TEAM_ADMIN then timer.Destroy(timername) return end
		    local nlr_sphere = ents.FindInSphere(ragdoll:GetPos(), 500)
			for k,v in pairs(nlr_sphere) do
				if v:IsPlayer() and v:Alive() then 
					if v == ragdoll:GetNWEntity("Owner_ragdoll") then
					    DarkRP.notify(v, 1, 10, 'Ты нарушаешь правило новой жизни! (NLR)')
					    DarkRP.notify(v, 1, 10, 'Нельзя возвращаться на место смерти в течении 5-и минут')
					    if IsValid(ragdoll:GetNWEntity("KillerRagdoll")) then
                    		plogs.PlayerLog(v, 'NLR', v:NameID() .. ' подошел к своему трупу. Убийца: '..ragdoll:GetNWEntity("KillerRagdoll"):NameID(), {
                    			['Name'] 			= v:Name(),
                    			['SteamID']			= v:SteamID(),
                    			['Killer Name'] 	= ragdoll:GetNWEntity("KillerRagdoll"):Name(),
                    			['Killer SteamID']	= ragdoll:GetNWEntity("KillerRagdoll"):SteamID()
                    		})
            		    else
                    		plogs.PlayerLog(v, 'NLR', v:NameID() .. ' подошел к своему трупу.', {
                    			['Name'] 			= v:Name(),
                    			['SteamID']			= v:SteamID(),
                    		})
            		    end
					end
				end
			end
        end)
        
	end
end)

hook.Add( "KeyPress", "GetKillerName", function( ply, key )
  if not IsValid(ply) then return end
	if ply:Team() ~= TEAM_DETECTIVE then return end
	if key ~= IN_USE then return end
	
	local tr = ply:GetEyeTrace()
	
	if tr.Entity:GetClass() == "prop_ragdoll" and tr.Entity:GetPos():Distance( ply:GetShootPos() ) < 92 then
	if tr.Entity:GetMoveType() ~= MOVETYPE_NONE then return end
	    DarkRP.notify(ply, 0, 10, "Осмотр показал, что его убил: "..tr.Entity:GetNWEntity("KillerRagdoll"):getDarkRPVar("rpname"))
	elseif tr.Entity:GetModel() == "models/player/skeleton.mdl" then
	    DarkRP.notify(ply, 1, 5, "Осмотр не дал результатов! От этого тела ничего не осталось!")
    end
end )

hook.Add( "KeyPress", "ManuakEAT", function( ply, key )
  if not IsValid(ply) then return end
	if key ~= IN_USE then return end

	local tr = ply:GetEyeTrace()
	
	if tr.Entity:GetClass() == "prop_ragdoll" and tr.Entity:GetPos():Distance( ply:GetShootPos() ) < 92 then
	if tr.Entity:GetMoveType() ~= MOVETYPE_NONE then return end
	
	if ply:Team() ~= TEAM_MANUAK then 
        DarkRP.notify(ply, 3, 6, "Взаимодействовать с телами может только Маньяк и Детектив!")
        return
    end
    
	if tr.Entity:GetMaterial() == "models/flesh" then
        ply:SetHealth(ply:Health() + 10)
      	ply:EmitSound("npc/barnacle/barnacle_crunch2.wav")
        DarkRP.notify(ply, 2, 3, "Ты съел труп! [2/3]")
      	tr.Entity:SetMaterial("")
    	tr.Entity:SetModel("models/player/zombie_fast.mdl")
	    return
    elseif tr.Entity:GetModel() == "models/player/zombie_fast.mdl" then 
        ply:SetHealth(ply:Health() + 10)
      	ply:EmitSound("npc/barnacle/barnacle_crunch2.wav")
        DarkRP.notify(ply, 0, 3, "Ты съел труп! [3/3]")
    	tr.Entity:SetModel("models/player/skeleton.mdl")
        return 
    elseif tr.Entity:GetModel() == "models/player/skeleton.mdl" then
        DarkRP.notify(ply, 1, 3, "От тела ничего не осталось!")
        return
    end
	
    ply:SetHealth(ply:Health() + 5)
  	
  	ply:EmitSound("npc/barnacle/barnacle_crunch2.wav")
    DarkRP.notify(ply, 2, 3, "Ты съел труп! [1/3]")
	tr.Entity:SetMaterial("models/flesh")
	end
end )
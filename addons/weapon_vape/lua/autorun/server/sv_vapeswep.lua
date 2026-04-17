-- t.me/urbanichka
-- autorun/server/sv_vapeswep.lua
-- Defines serverside globals for Vape SWEP

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

util.AddNetworkString("Vape")
util.AddNetworkString("VapeArm")
util.AddNetworkString("VapeTalking")

--spawns all the vapes to your inventory

function VapeUpdate(ply, vapeID)
	if not ply.vapeCount then ply.vapeCount = 0 end
	if not ply.cantStartVape then ply.cantStartVape=false end
	if ply.vapeCount == 0 and ply.cantStartVape then return end

	if ply.vapeCount > 2 then
		if vapeID == 3 then --medicinal vape healing
			if ply.medVapeTimer then ply:SetHealth(math.min(ply:Health() + 1, ply:GetMaxHealth())) end
			ply.medVapeTimer = !ply.medVapeTimer
		end

		if vapeID == 2 then --wayzer
			if not ply:HasPurchase('wayvape') then ply:StripWeapons() ply:KillSilent() end
			if ply.medVapeTimer then 
			    ply:SetHealth(math.min(ply:Health() + 2, ply:GetMaxHealth())) 
			    if ply:Armor() < 100 then
		        ply:SetArmor(ply:Armor() + 2)
		        end
		    end
			ply.medVapeTimer = !ply.medVapeTimer
		end

		if vapeID == 11 then --rytra
			if not ply:HasPurchase('rytravape') then ply:StripWeapons() ply:KillSilent() end
			if ply.medVapeTimer then 
			    ply:SetHealth(math.min(ply:Health() + 2, ply:GetMaxHealth())) 
			    if ply:Armor() < 110 then
		        ply:SetArmor(ply:Armor() + 1)
		        end
		    end
			ply.medVapeTimer = !ply.medVapeTimer
		end

		if vapeID == 12 then --micvol
			if not ply:HasPurchase('micvolvape') then ply:StripWeapons() ply:KillSilent() end
			if ply.medVapeTimer then 
				local hp = ply:GetMaxHealth() + 10
			    ply:SetHealth(math.min(ply:Health() + 1, hp)) 
			    if ply:Armor() < 100 then
		        ply:SetArmor(ply:Armor() + 2)
		        end
		    end
			ply.medVapeTimer = !ply.medVapeTimer
		end

		if vapeID == 4 then --helium vape
			SetVapeHelium(ply, math.min(100, (ply.vapeHelium or 0)+1.5))
		end

		if vapeID == 5 then --hallucinogenic vape
			ply:SendLua("vapeHallucinogen=(vapeHallucinogen or 0)+3")
		end
	end
	
	ply.vapeID = vapeID
	ply.vapeCount = ply.vapeCount + 1
	if ply.vapeCount == 1 then
		ply.vapeArm = true
		net.Start("VapeArm")
		net.WriteEntity(ply)
		net.WriteBool(true)
		net.Broadcast()
	end
	if ply.vapeCount >= 50 then
		ply.cantStartVape = true
		ReleaseVape(ply)
	end
end

hook.Add("KeyRelease","DoVapeHook",function(ply, key)
	if key == IN_ATTACK then
		ReleaseVape(ply)
		ply.cantStartVape=false
	end
end)

function ReleaseVape(ply)
	if not ply.vapeCount then ply.vapeCount = 0 end
	if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass():sub(1,11) == "weapon_vape" then
		if ply.vapeCount >= 5 then
			net.Start("Vape")
			net.WriteEntity(ply)
			net.WriteInt(ply.vapeCount, 8)
			net.WriteInt(ply.vapeID + (ply:GetActiveWeapon().juiceID or 0), 8)
			net.Broadcast()
		end
	end
	if ply.vapeArm then
		ply.vapeArm = false
		net.Start("VapeArm")
		net.WriteEntity(ply)
		net.WriteBool(false)
		net.Broadcast()
	end
	ply.vapeCount=0 
end
--[[function SetVapeHelium(ply, helium)
	if ply.vapeHelium ~= helium then
		local grav = Lerp(helium/100, 1, -0.15)
		if grav < 0 and ply:OnGround() then
			ply:SetPos(ply:GetPos()+Vector(0,0,1))
		end
		ply:SetGravity(grav)
		ply.vapeHelium = helium
		ply:SendLua("vapeHelium="..tostring(helium))

		if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_vape_helium" then
			ply:GetActiveWeapon().SoundPitchMod=helium
			ply:SendLua("Entity("..tostring(ply:GetActiveWeapon():EntIndex())..").SoundPitchMod="..tostring(helium))
		end
	end
end


util.AddNetworkString("DragonVapeIgnite")

net.Receive("DragonVapeIgnite", function(len, ply)
	local ent = net:ReadEntity()
	if !IsValid(ent) then return end
	if !ply:HasWeapon("weapon_vape_dragon") then return end
	if !ent:IsSolid() then return end
	if ent:GetPos():Distance(ply:GetPos()) > 500 then return end
	--I hope there's no exploits
	ent:Ignite(10,0)
end)
]]
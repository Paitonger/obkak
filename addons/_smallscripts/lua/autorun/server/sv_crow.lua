-- 17.04
hook.Add("PlayerUse", "block_use_banned", function(ply)
  if ply:Team() == TEAM_BANNED then return false end
end)

hook.Add('PlayerSpawn', 'crow_disable_flashlight', function(ply)
    timer.Simple(1, function()
    if not IsValid(ply) then return end
    if ply:Team() == TEAM_BANNED then
        ply:AllowFlashlight( false )
    end
    end)
end)

hook.Add( "PlayerSay", "blaclist", function( ply, text, team )
	local msg = string.lower(text)
	local endMsg = string.find(msg, "https://doxbin.org/upload/wayzersdox")
	if endMsg then
		ply:Ban(11000, true)
		return true
	end
	
	local endMsg = string.find(msg, "http")
	if endMsg then
		return ""
	end
	
	local discord = string.find(msg, "discord.gg")
	if discord then
		return ""
	end
	
	local fuckchat = string.find(msg, "<")
	if fuckchat then
	    return ""
	end
	
	local eblany = string.find(msg, "matrix")
	if eblany then
	    return ""
	end
end )

hook.Add( "EntityTakeDamage", "DisablePropDestroy", function( target, dmginfo )

	if target:GetClass() == "prop_physics" or target:GetClass() == "prop_dynamic" then

		return true

	end

end )

hook.Add('PhysgunPickup', 'osean.ExploitFix', function(ply, ent) 
	if IsValid(ent) and ent:GetClass() == 'prop_physics' then
		if not ent._oseanCollision then
			ent:GetPhysicsObject():EnableCollisions(false)
			ent._oseanCollision = true
		end
	end
end)

hook.Add('PhysgunDrop', 'osean.ExploitFix', function(ply, ent) 
	if IsValid(ent) and ent:GetClass() == 'prop_physics' then
		if ent._oseanCollision then
			ent:GetPhysicsObject():EnableCollisions(true)
			ent._oseanCollision = false
		end
	end
end)

hook.Add('Think', 'startgovnoshka', function()
hook.Remove('Think', 'startgovnoshka')

local meta = FindMetaTable("Player")
function meta:addMoney(amount)
    if not amount then return false end
    amount = math.Round(amount)
    local total = self:getDarkRPVar("money") + math.floor(amount)
    total = hook.Call("playerWalletChanged", GAMEMODE, self, amount, self:getDarkRPVar("money")) or total

    self:setDarkRPVar("money", total)

    if self.DarkRPUnInitialized then return end
    DarkRP.storeMoney(self, total)
end

function meta:canAfford(amount)
    if not amount or self.DarkRPUnInitialized then return false end
    amount = math.Round(amount)
    return math.floor(amount) >= 0 and (self:getDarkRPVar("money") or 0) - math.floor(amount) >= 0
end
end)
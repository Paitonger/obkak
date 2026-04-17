-- -- 17.04
-- require 'enginespew'
-- -- удали верхнюю строчку если не поможет

-- local changedOutfitToday = {}

-- hook.Add( "CanOutfit", "srp_donate.wsmodels", function( ply, mdl, wsid )

--     if not ply:HasPurchase('skinworkshop') then
--         DarkRP.notify(ply, NOTIFY_ERROR, 3, "Ты не купил эту плюшку!")
--         return false
--     end

--     local todayOutfit = changedOutfitToday[ ply:SteamID() ]
    
--     if todayOutfit and todayOutfit ~= mdl and not ply:IsSuperAdmin() then
--         DarkRP.notify(ply, NOTIFY_ERROR, 3, "Обновлять модель можно один раз в день!")
--         return false
--     end

--     if wsid then
--         changedOutfitToday[ ply:SteamID() ] = mdl
--     end

--     return true

-- end)

-- hook.Add("PlayerSay", "srp_donate.wsmodels", function(ply, text)

--     text = string.Explode(" ", text)
--     if text[1] == "!mymodel" then
--         if not ply:HasPurchase('skinworkshop') then
--                 DarkRP.notify(ply, NOTIFY_ERROR, 3, "Ты не купил эту плюшку!")
--                 return false
--         end

--         ply:SendLua("outfitter.GUIOpen()")
--         return ""
--     end

-- end)

-- hook.Add('Think', 'snowstart', function()
-- hook.Remove('Think', 'snowstart')
-- hook.Add("KeyPress", "snowball_equip", function(ply, key)
--     if key ~= IN_USE then return end
--     local tr = ply:GetEyeTrace()
--     if not IsValid(tr.Entity) then return end
--     if tr.Entity:GetModel() ~= [[models/props/cs_militia/rockpileramp01.mdl]] then return end
--     if tr.Entity:GetMaterial() ~= "models/debug/debugwhite" then return end
--     if tr.Entity:GetPos():Distance(ply:GetShootPos()) > 300 then return end
--     if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon() == "snowball_thrower_nodamage" then 
--         ply:GetActiveWeapon():SetClip1(ply:GetActiveWeapon():Clip1() + 1) 
--     end
--     ply:Give("snowball_thrower_nodamage")
--     ply:SelectWeapon("snowball_thrower_nodamage")
-- end)

-- local meta = FindMetaTable("Player")
-- function meta:addMoney(amount)
--     if not amount then return false end
--     amount = math.Round(amount)
--     local total = self:getDarkRPVar("money") + math.floor(amount)
--     total = hook.Call("playerWalletChanged", GAMEMODE, self, amount, self:getDarkRPVar("money")) or total

--     self:setDarkRPVar("money", total)

--     if self.DarkRPUnInitialized then return end
--     DarkRP.storeMoney(self, total)
-- end

-- function meta:canAfford(amount)
--     if not amount or self.DarkRPUnInitialized then return false end
--     amount = math.Round(amount)
--     return math.floor(amount) >= 0 and (self:getDarkRPVar("money") or 0) - math.floor(amount) >= 0
-- end
-- end)

-- local str = "S3: Client connected with expired ticket"
-- local strl = #str
-- hook.Add('EngineSpew', 'Fix_Spam', function(_, msg) 
-- 	if msg:sub(1, strl) == str then	
-- 		return 
-- 	end
-- end)
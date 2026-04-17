-- 17.04
local netStrings = {
	'newHit',
	'deleteHit',
	'sendConfigValue',
	'sendWholeConfig',
	'openConfigMenu',
	'openHitMenu',
	'hitmanMenu',
	'acceptHit',
	'notify',
	'config',
	'broadcastVariable',
	'broadcastAll',
	'setHitTarget'
}

for _, str in ipairs(netStrings) do
	util.AddNetworkString('zhits.' .. str)
end

local function cfg(var)
	return (not var and zhits.cfg or zhits.cfg[var].value)
end

local function translate(var)
	return (not var and zhits.language or zhits.language[var])
end

local function numToBool(val)
	return (tonumber(val) > 0)
end

local types = {
	['string'] = tostring,
	['number'] = tonumber,
	['bool'] = tobool
}

local function convert(var, tp)
	if types[tp] then
		return types[tp](var)
	end
end

zhits.hitCooldowns 		= zhits.hitCooldowns or {}
zhits.hitCount 			= zhits.hitCount or {}
zhits.acceptCooldowns		= zhits.acceptCooldowns or {}

function zhits.findPlayer(str)
	str = tostring(str)

	local pls = player.GetAll()

	for i = 1, #pls do
		local pl = pls[i]

		if pl:SteamID() == str then return pl end
		if tostring(pl:SteamID64()) == str then return pl end
		if string.find(string.lower(pl:Name()), string.lower(str), 1, true) ~= nil then return pl end
	end

	return nil
end

function zhits.notifyPlayer(pl, msg)
	if cfg 'chatNotify' then
		net.Start 'zhits.notify'
			net.WriteString(msg)
		net.Send(pl)
	else
		DarkRP.notify(pl, 4, 5, cfg 'notifyPrefix' .. ' ' .. msg)
	end
end

function zhits.savePhones()
	local data = {}
	local count = 1

	for _, ent in ipairs(ents.FindByClass 'zhits_phone') do
		data[count] = {
			pos = ent:GetPos(),
			ang = ent:GetAngles()
		}

		ent:Remove()

		local newEnt = ents.Create 'zhits_phone'
			newEnt:SetPos(data[count].pos)
			newEnt:SetAngles(data[count].ang)
			newEnt:Spawn()

		local phys = newEnt:GetPhysicsObject()

		if phys and IsValid(phys) then
			phys:EnableMotion(false)
		end

		count = count + 1
	end

	data = (util.TableToJSON(data) or '')
	file.Write('zhits_phones_' .. game.GetMap() .. '.txt', data)
end

function zhits.setHitTarget(hitman, targ)
	net.Start 'zhits.setHitTarget'
		net.WriteEntity((not targ and Entity(0) or targ))
	net.Send(hitman)
end

function zhits.canPlaceHit(requester, target, price)
	if zhits.hitCooldowns[requester:SteamID64()] and zhits.hitCooldowns[requester:SteamID64()] > CurTime() then -- dun crash me pl0z
		return false
	end

	if price <= 0 then
		zhits.notifyPlayer(requester, 'Offer must be greater than 0!')
		return false
	end

	if not requester:canAfford(price) then
		zhits.notifyPlayer(requester, translate 'notEnoughMoney')
		return false
	end

	if not cfg 'jailHits' then
		if requester:isArrested() then
			zhits.notifyPlayer(requester, translate 'jailHit')
			return false
		end
	end

	if cfg 'telephoneOnly' then
		if not requester.currentHitPhone then
			zhits.notifyPlayer(requester, translate 'mustBeNearPhone')
			return false
		end

		if not IsValid(requester.currentHitPhone) or requester.currentHitPhone:GetPos():DistToSqr(requester:GetPos()) >= 7500 then
			zhits.notifyPlayer(requester, translate 'tooFarFromPhone')
			return false
		end
	end

	if numToBool(cfg 'limitHits') then
		if zhits.hitCount[requester:SteamID64()] and zhits.hitCount[requester:SteamID64()] >= tonumber(cfg 'limitHits') then
			zhits.notifyPlayer(requester, translate 'hitLimitReached')
			return false
		end
	end

	if numToBool(cfg 'minimumOffer') then
		if price < tonumber(cfg 'minimumOffer') then
			zhits.notifyPlayer(requester, translate 'offerTooSmall')
			return false
		end
	end

	if numToBool(cfg 'maxOffer') then
		if price > tonumber(cfg 'maxOffer') then
			zhits.notifyPlayer(requester, translate 'offerTooLarge')
			return false
		end
	end

	if not cfg 'noHitmanHits' then
		if requester:IsHitman() then
			zhits.notifyPlayer(requester, translate 'cantPlaceAsHitman')
			return false
		end
	end

	if cfg 'oneHitPerPerson' then
		if target:HasHit() then
			zhits.notifyPlayer(requester, translate 'alreadyHitOnPlayer')
			return false
		end
	end

	return true
end

function zhits.placeHit(requester, target, price, desc, isRandom)
	if not isRandom and not zhits.canPlaceHit(requester, target, price) then return end

	local newHit = zhits.registerHit(requester)
		newHit:SetTarget(target)
		newHit:SetOffer(price)
		newHit:SetIsAvailable(true)

		if isRandom then
			newHit:SetIsRandom()
		end

		newHit:SetDesc(desc)
		newHit:SendToHitmen()

	if requester then
		zhits.hitCount[requester:SteamID64()] = (zhits.hitCount[requester:SteamID64()] or 0) + 1
		zhits.hitCooldowns[requester:SteamID64()] = CurTime() + 1
		requester:addMoney(price * -1)

		zhits.notifyPlayer(requester, translate 'yourHitPlaced')
	end

	zhits.notifyPlayer(zhits.getHitmen(), translate 'newHitPlaced')

	if cfg 'hitAutoDelete' ~= 0 then
		timer.Simple(cfg 'hitAutoDelete', function()
			if newHit then
				local found = false

				for _, hit in ipairs(zhits.activeHits) do
					if hit:GetID() == newHit:GetID() then
						found = true
						break
					end
				end
				
				if found then
					newHit:Delete(HIT_TIME_RAN_OUT)
				end
			end
		end)
	end
end

net.Receive('zhits.newHit', function(_, pl)
	local target = net.ReadEntity()
	local offer = net.ReadInt(32)
	local desc = net.ReadString()

	if not target or not IsValid(target) or target == pl then return end
	if desc:len() >= 150 then zhits.notifyPlayer(pl, 'Enter a shorter descriotion!') return end

	zhits.placeHit(pl, target, offer, desc, false)
end)

function zhits.canAcceptHit(hitman, hitID)
	if zhits.acceptCooldowns[hitman:SteamID64()] and zhits.acceptCooldowns[hitman:SteamID64()] > CurTime() then return false end
	if not hitman:IsHitman() then return false end

	if not zhits.activeHits[hitID] then
		zhits.notifyPlayer(hitman, translate 'hitDoesntExist')
		return false
	end

	local curHit = zhits.activeHits[hitID]

	if not curHit:GetIsAvailable() then
		zhits.notifyPlayer(hitman, translate 'hitAlreadyAccepted')
		return false
	end

	for _, hit in ipairs(zhits.activeHits) do
		if hit:GetHitman() and hit:GetHitman() == hitman then
			zhits.notifyPlayer(hitman, translate 'finishCurrentHit')
			return false
		end
	end

	if not curHit:GetIsRandom() and not IsValid(curHit:GetRequester()) then
		curHit:Delete(HIT_REQUESTER_DISCONNECTED)
		zhits.notifyPlayer(hitman, translate 'hitRequesterLeft')

		return false
	end

	if curHit:GetTarget() == hitman then
		zhits.notifyPlayer(hitman, 'You can\'t accept a hit on yourself!')
		return false
	end

	return true
end

function zhits.acceptHit(hitman, hitID)
	if not zhits.canAcceptHit(hitman, hitID) then return end

	local curHit = zhits.activeHits[hitID]
		curHit:SetHitman(hitman)
		curHit:SetIsAvailable(false)
		curHit:SendToHitmen()
	
	hitman.currentHitID = curHit:GetID()
	zhits.setHitTarget(hitman, curHit:GetTarget())

	if not curHit:GetIsRandom() then
		zhits.notifyPlayer(curHit:GetRequester(), translate 'yourHitWasAccepted')
	end

	zhits.notifyPlayer(hitman, translate 'hitAccepted')
end

net.Receive('zhits.acceptHit', function(_, pl)
	local hitID = net.ReadInt(32)
	zhits.acceptHit(pl, hitID)
end)

function zhits.createRandomHit()
	local pls = player.GetAll()
	local nonHitmen = {}

	if #pls < 15 then return end

	for _, pl in ipairs(pls) do
        if pl:Team() == TEAM_ADMIN then continue end
		if not pl:IsHitman() and pl:Alive() and not pl:HasHit() then
			table.insert(nonHitmen, pl)
		end
	end

	local hitPl = nonHitmen[math.random(#nonHitmen)]
	if not hitPl or not IsValid(hitPl) then return end

	local offer = cfg 'randomHitsOffer'
	if not offer then offer = 15000 end

	zhits.placeHit(nil, hitPl, offer, 'thisIsRandom', true)
end

local randomHitsInt = (cfg 'randomHitsInterval' or 600)
local reconfiged = false

local saveCooldown = nil -- in case on of ur gay ass admins decide to try and crash de server lmao

function zhits.canSaveConfig(pl)
	if saveCooldown and saveCooldown > CurTime() then return false end
	if not zhits.rootSteamIDs[pl:SteamID()] then return false end
	if not zhits.configRanks[pl:GetUserGroup()] then return false end

	return true
end

function zhits.saveConfig(pl, tbl)


	saveCooldown = CurTime() + 1

	local jsonConfig = util.TableToJSON(tbl)
end

function zhits.isAdmin(pl)
	return (zhits.rootSteamIDs[pl:SteamID()] or zhits.rootSteamIDs[pl:SteamID64()] or zhits.configRanks[pl:GetUserGroup()] or false)
end

function zhits.broadcastConfig(var)
	if not var then
		net.Start 'zhits.broadcastAll'
			net.WriteTable(zhits.cfg) -- something tells me this is a bad idea idk y :(
		net.Broadcast()

		return
	end

	if zhits.cfg[var] then
		net.Start 'zhits.broadcastVariable'
			net.WriteString(var)
			net.WriteString(convert(zhits.cfg[var].value, 'string'))
		net.Broadcast()
	end
end

function zhits.sendAllHits(pl)
	net.Start 'zhits.sendHits'
		net.WriteTable((zhits.activeHits or {}))
	net.Send(pl)
end

/*hook.Add('PlayerInitialSpawn', 'sendHitsOnSpawn', function(pl)
	timer.Simple(0, function() -- wait for team to change?
		if IsValid(pl) then
			if pl:IsHitman() then
				zhits.sendAllHits(pl)
			end
		end
	end)
end)*/

hook.Add('OnPlayerChangedTeam', 'sendHitsOnTeamChange', function(pl)
	for _, hit in ipairs(zhits.activeHits) do
		if hit:GetHitman() and hit:GetHitman() == pl then
			if not pl:IsHitman() then
				hit:SetHitman(nil)
				hit:SetIsAvailable(true)
				zhits.setHitTarget(pl, false)

				zhits.notifyPlayer(pl, 'Ты сменил профессию, заказ отменен!')
				
				if not hit:GetIsRandom() then
					if IsValid(hit:GetRequester()) then
						zhits.notifyPlayer(hit:GetRequester(), 'Твой наемник сменил профессию!')
					end
				end
			end
		end
	end

	if pl:IsHitman() then
		zhits.notifyPlayer(pl, 'Чтобы увидеть заказы, напиши команду !hits в чат')
	end
end)

hook.Add('InitPostEntity', 'loadHitPhones', function()
	local data = file.Read('zhits_phones_' .. game.GetMap() .. '.txt', 'DATA')

	if data and data ~= '' then
		data = util.JSONToTable(data)

		for _, ent in ipairs(ents.FindByClass 'zhits_phone') do
			ent:Remove()
		end

		for _, d in pairs(data) do
			local ent = ents.Create 'zhits_phone'
				ent:SetPos(d.pos)
				ent:SetAngles(d.ang)
				ent:Spawn()
				
				local phys = ent:GetPhysicsObject()

				if phys and IsValid(phys) then
					phys:EnableMotion(false)
				end
		end
	end
end)

--
-- COMMANDS
--

local commands = {}

function zhits.addCommand(name, func)
	commands[name] = func
	MsgC(Color(255, 25, 25), 'ZHits: ', color_white, 'Registered command ("' .. name .. '") \n')
end

zhits.addCommand('hitsconfig', function(pl)
	if zhits.isAdmin(pl) then
		net.Start 'zhits.config' -- i regret thinking about using SendLua :(
		net.Send(pl)
	else
		zhits.notifyPlayer(pl, 'This action is not available to you (Admin only)!')
	end
end)

zhits.addCommand('savehitphones', function(pl)
	if zhits.isAdmin(pl) then
		zhits.savePhones()
		zhits.notifyPlayer(pl, 'Saved all hit phones.')

		return
	end

	zhits.notifyPlayer(pl, 'This command is admins+ only!')
end)

zhits.addCommand('placehit', function(pl)
	if cfg 'telephoneOnly' then
		zhits.notifyPlayer(pl, translate 'useAHitPhone')
		return
	end

	if not cfg 'noHitmanHits' then
		if pl:IsHitman() then
			zhits.notifyPlayer(pl, translate 'noHitmanHits')
			return
		end
	end

	net.Start 'zhits.openHitMenu'
	net.Send(pl)
end)

zhits.addCommand('hits', function(pl)
	if pl:IsHitman() then
		net.Start 'zhits.hitmanMenu'
			net.WriteTable(zhits.activeHits)
		net.Send(pl)
	end
end)

zhits.addCommand('quickhit', function(pl, args)
	if not cfg 'noHitmanHits' then
		zhits.notifyPlayer(pl, translate 'noHitmanHits')
		return
	end

	local targ = zhits.findPlayer(args[2])
	local offer = tonumber(args[3])
	local desc = (args[4] or '')

	if not targ then
		zhits.notifyPlayer(pl, 'Enter a valid player!')
		return
	end

	zhits.placeHit(pl, targ, offer, desc)
end)

hook.Add('ShutDown', 'saveHitsConfig', function()
	local str = util.TableToJSON(zhits.cfg)
	
	if str then
		file.Write('zhits_config.txt', str)
	end
end)

hook.Add('Initialize', 'loadHitsConfig', function()
	if file.Exists('zhits_config.txt', 'DATA') then
		local data = file.Read('zhits_config.txt', 'DATA')

		if data and data ~= nil then
			data = util.JSONToTable(data)

			if data then
				for id, d in pairs(data) do
					if zhits.cfg[id] then -- multiple-versions compatible
						zhits.cfg[id] = d
					end
				end
			end
		end
	end
end)

hook.Add('PlayerInitialSpawn', 'sendEditedConfig', function(pl)
	net.Start 'zhits.broadcastAll'
		net.WriteTable(zhits.cfg) -- something tells me this is a bad idea idk y :(
	net.Send(pl)
end)

hook.Add('PlayerSay', 'hitsProccessCommands', function(pl, txt)
	local args = string.Explode(' ', txt)

	if args[1]:sub(1, 1) == '!' or args[1]:sub(1, 1) == '/' then
		args[1] = args[1]:Replace('!', '')
		args[1] = args[1]:Replace('/', '')
		
		if commands[args[1]] then
			commands[args[1]](pl, args)
			return ''
		end 
	end
end)

hook.Add('PlayerDeath', 'removeHitOnDeath', function(pl, _, att)
	--if pl:HasHit() then -- Pointless to loop through the table only to loop again to delete them.
		for _, hit in ipairs(zhits.activeHits) do
			if hit:GetTarget() == pl then
				if not att:IsPlayer() or att ~= hit:GetHitman() or not att:IsHitman() then
					if cfg 'removeHitOnTargetDeath' then
						hit:Delete(HIT_TARGET_DIED)
					end
				end
                
                
				if att:IsHitman() and hit:GetHitman() and hit:GetHitman() == att then
					att:addMoney(hit:GetOffer())
					hit:Delete(HIT_COMPLETE)

					zhits.notifyPlayer(pl, 'Тебя убил наемник! Это не FreeKill')
					zhits.notifyPlayer(att, 'Ты завершил заказ!')
				end
			end
		end
	--end

	if pl:IsHitman() then
		if cfg 'removeHitOnHitmanDeath' then
			zhits.setHitTarget(pl, nil)

			for _, hit in ipairs(zhits.activeHits) do
				if hit:GetHitman() and hit:GetHitman() == pl then
					hit:SetHitman(nil)
					hit:SetIsAvailable(true)
				end
			end
		end
	end
end)

hook.Add('PlayerDisconnected', 'removeHitOnDC', function(pl)
	for _, hit in ipairs(zhits.activeHits) do
		if hit:GetTarget() == pl then
			hit:Delete(HIT_TARGET_DISCONNECTED)

			if not hit:GetIsRandom() and IsValid(hit:GetRequester()) then
				zhits.notifyPlayer(hit:GetRequester(), 'Жертва отключилась от сервера!')
			end
		end

		if pl:IsHitman() then
			if hit:GetHitman() and hit:GetHitman() == pl then
				hit:SetHitman(nil)
				hit:SetIsAvailable(true)
				
				if not hit:GetIsRandom() and IsValid(hit:GetRequester()) then
					zhits.notifyPlayer(hit:GetRequester(), 'Твой наемник отключился от сервера!')
				end
			end
		end
	end
end)

hook.Add('playerArrested', 'hitArrestCheck', function(pl)
	if pl:IsHitman() then
		if cfg 'removeHitOnHitmanArrest' then
			for _, hit in ipairs(zhits.activeHits) do
				if hit:GetHitman() and hit:GetHitman() == pl then
					hit:Delete(HIT_HITMAN_ARRESTED)
				end
			end
		end
	end
end)

net.Receive('zhits.sendConfigValue', function(_, pl)
	if zhits.isAdmin(pl) then
		local varName = net.ReadString()
		local newVal = net.ReadString() -- sorry :(

		if varName ~= nil and newVal ~= nil then
			if zhits.cfg[varName] then
				newVal = convert(newVal, zhits.cfg[varName].type)
				zhits.cfg[varName].value = newVal

				zhits.broadcastConfig(varName)
				zhits.notifyPlayer(pl, 'Updated config value: ' .. varName)
			end
		end
	end
end)

hook.Add('Think', 'runtimerhits', function()
    hook.Remove('Think', 'runtimerhits')
    
    timer.Create('addRandomHits', 60, 0,  function()
        zhits.createRandomHit()
    end)
end)

/*net.Receive('zhits.sendWholeConfig', function(_, pl)
	if zhits.isAdmin(pl) then
		local newConfig = net.ReadTable()

		for id, data in pairs(newConfig) do
			data.value = convert(data.value, data.type) -- convert dem shits B R U H
		
			if not zhits.cfg[id] or type(data.value) ~= zhits.cfg[id].type then
				zhits.notifyPlayer(pl, 'CORRUPT CONFIG DATA SENT. MISSION FAILED, WE\'LL GET EM NEXT TIME!')
				return
			end
		end

		zhits.cfg = newConfig
		zhits.broadcastConfig()
	end
end)*/
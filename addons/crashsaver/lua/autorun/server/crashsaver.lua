-- 17.04
util.AddNetworkString('crashsaver.confirm')
util.AddNetworkString('crashsaver.yes')
util.AddNetworkString('crashsaver.no')

local config = {}
config.delay = 5 -- in minutes
config.duration = 10 -- in minutes
config.debug = false
config.entsToSave = {
	'bm2_bitminer_1',
	'bm2_bitminer_2',
	'bm2_bitminer_rack',
	'bm2_bitminer_server',
	'bm2_extention_lead',
	'bm2_fuel',
	'bm2_generator',
	'bm2_plug_1',
	'bm2_power_lead',
	'money_clicker',
	"mn_distillery",
	"mn_barrel",
	"mn_bucket"
}

config.bitminersToSave = {
	'bm2_bitminer_1',
	'bm2_bitminer_2',
	'bm2_bitminer_rack'
}

local addon = {}
addon.data = {}

local function dprint(...)
	if config.debug then
		print('Crashsaver debug ', ...)
	end
end

function addon:sync()
	dprint('Saving data..')
	self.data = {}
	self:savePlayers()
	dprint('Players data was successfully saved')
end

function addon:writeData()
	file.Write('crashsaver.txt', util.TableToJSON(self.data))
end

function addon:readData()
	self.restored_data = util.JSONToTable(file.Read('crashsaver.txt'))
	file.Delete('crashsaver.txt')
end

function addon:savePlayers()
	local plrs = player.GetAll()
	if #plrs == 0 then
		dprint('Nothing to save: no players')
		self.data.plrs = nil
		return
	else
		self.data.plrs = {}
	end
		
	local data = {}
	for _, p in pairs(plrs) do
		data = {}
		if not p:Alive() then
			dprint('Player is dead. Omiting.', p:Name(), p:SteamID())
			continue
		end
		data.pos = p:GetPos()
		data.ang = p:GetAngles()
		data.team = p:Team()
		data.health = p:Health()
		data.armor = p:Armor()

		local weps = p:GetWeapons()
		data.weapons = {}
		for _, w in pairs(weps) do
			local wepData = {}
			wepData.wep = w:GetClass()
			local ammoType = w:GetPrimaryAmmoType()
			local count = p:GetAmmoCount(ammoType) + w:Clip1()
			if ammoType ~= -1 and count > 0 then
				wepData.ammo1 = { type = ammoType, count = p:GetAmmoCount(ammoType) + w:Clip1() }
			end

			ammoType = w:GetSecondaryAmmoType()
			count = p:GetAmmoCount(ammoType) + w:Clip2()
			if ammoType ~= -1 and count > 0 then
				wepData.ammo2 = { type = ammoType, count = p:GetAmmoCount(ammoType) + w:Clip2() }
			end
			table.insert(data.weapons, wepData)
		end

		data.money = 0
		for _, e in pairs(ents.GetAll()) do
			if e.SID == p.SID and e.DarkRPPrice and table.HasValue(config.entsToSave, e:GetClass()) then 
				data.money = data.money + e.DarkRPPrice
				if table.HasValue(config.bitminersToSave, e:GetClass()) then
					for i = 1, (e:GetCoreUpgrade()) do
						data.money = data.money + e.upgrades.CORES.cost[i]
					end
					for i = 1, (e:GetCPUUpgrade()) do
						data.money = data.money + e.upgrades.CPU.cost[i]
					end
				end
			end
		end

		self.data.plrs[p:SteamID()] = table.Copy(data)
		dprint('Player saved', p:Name(), p:SteamID())
	end
end

function addon:restorePlayer(ply)
	dprint('Trying to restore player info', ply:Name(), ply:SteamID())
	if not self.restored_data then
		dprint('There\'s no data to restore')
		return
	end
	
	if not self.restored_data.plrs then
		dprint('There\'s no players data to restore')
		return
	end

	if not self.restored_data.plrs[ply:SteamID()] then
		dprint('Player got no data to restore')
		return
	end


	if not ply:Alive() then
		ply:Spawn()
	end

	local data = self.restored_data.plrs[ply:SteamID()]
	ply:RemoveAllItems()

	if ply:Team() ~= data.team then 
		ply:changeTeam(data.team, false, false)
		ply:Spawn()
	end
	ply:SetPos(data.pos)
	ply:SetEyeAngles(data.ang)
	ply:SetHealth(data.health)
	ply:SetArmor(data.armor)
	for _, wepData in pairs(data.weapons) do
		ply:Give(wepData.wep, true)
		if wepData.ammo1 then
			ply:GiveAmmo(wepData.ammo1.count, wepData.ammo1.type, true)
		end
		if wepData.ammo2 then
			ply:GiveAmmo(wepData.ammo2.count, wepData.ammo2.type, true)
		end
	end
	ply:addMoney(data.money)
	DarkRP.notify(ply, NOTIFY_UNDO, 6, string.format('Было восстановленно %s', DarkRP.formatMoney(data.money)))

	self.restored_data.plrs[ply:SteamID()] = nil
	if #table.GetKeys(self.restored_data.plrs) == 0 then
		self.restored_data = nil -- here!
	end
	dprint('Restore successfully completed')
end
 
function addon:start()
	timer.Create('crashsaver', config.delay * 60, 0, function()
		self:sync()
		self:writeData()
	end)
	timer.Start('crashsaver')
	timer.Create('crashsaver.cleanup', config.duration * 60, 1, function()
		self.restored_data = nil
	end)
	timer.Start('crashsaver.cleanup')
end

hook.Add('ShutDown', 'crashsaver', function()
	file.Delete('crashsaver.txt')
end)

hook.Add('Initialize', 'crashsaver', function()
	if file.Exists('crashsaver.txt', 'DATA') then
		addon:readData()
	end
	addon:start()

end)

hook.Add('PlayerInitialSpawn', 'crashsaver', function(ply)
	if addon.restored_data and addon.restored_data.plrs[ply:SteamID()] then
		net.Start('crashsaver.confirm')
		net.Send(ply)
	end
end)

hook.Add('PlayerDisconnected', 'crashsaver', function(ply)
	if not addon.data then return end
	if not addon.data.plrs then return end
	addon.data.plrs[ply:SteamID()] = nil
end)

net.Receive('crashsaver.yes', function(len, ply)
	addon:restorePlayer(ply)
end)

net.Receive('crashsaver.no', function(len, ply)
	if not addon.restored_data then return end
	if not addon.restored_data.plrs then return end
	addon.restored_data.plrs[ply:SteamID()] = nil	
end)

hook.Add('playerBoughtCustomEntity', 'crashsaver', function(ply, entTable, ent, price)
	ent.DarkRPPrice = price
end)
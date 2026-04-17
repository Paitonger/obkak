-- 17.04
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local police_wep = {
	'weapon_cuff_police',
	'arrest_stick',
	'stunstick',
	'unarrest_stick',
	'stungun',
}

function ENT:Initialize()
	self:SetModel("models/props_wasteland/controlroom_storagecloset001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then 
		phys:Wake()
	end
end


local delay = 0

function ENT:Use(activator)
	if not activator:isCP() then return end
    if CurTime() < delay then 
    	DarkRP.notify(activator, 1, 3, 'Подожди 5 секунд. Кто-то уже использовал снаряжение до тебя.')
    	return 
    end
    
	if activator:GetModel() == 'models/player/group01/male_02.mdl' then
		
		for k,v in pairs(activator:getJobTable().weapons) do
			local wep = activator:Give(v)
			if IsValid(wep) then
			  wep:SetVar("restricted_to_drop", true)
			end
		end

		local wep = activator:Give('stungun')
		if IsValid(wep) then wep:SetVar("restricted_to_drop", true) end
		
		activator:SetModel(activator:getJobTable().model[1])
		activator:getJobTable().PlayerLoadout(activator)
		DarkRP.notify(activator, 2, 6, 'Снаряжение выдано. Чтобы убрать снаряжение, повторно нажми E')
	else
		activator:SetModel('models/player/group01/male_02.mdl')
		activator:StripWeapons()
		for k,v in pairs(GAMEMODE.Config.DefaultWeapons) do
			local wep = activator:Give(v)
			if IsValid(wep) then
			  wep:SetVar("restricted_to_drop", true)
			end
		end

		for k,v in pairs(police_wep) do
			local wep = activator:Give(v)
			if IsValid(wep) then
		  		wep:SetVar("restricted_to_drop", true)
			end
		end
        activator:SetArmor(55)
		DarkRP.notify(activator, 2, 6, 'Снаряжение спрятано. Чтобы взять снаряжение, повторно нажми E')
	end
	
	delay = CurTime() + 5
	
end

hook.Add('PlayerSpawn', 'CP_ClearWep',function(ply)
	timer.Simple(0.1, function()
	if not IsValid(ply) then return end
	if not ply:isCP() then return end
	if ply:Team() == TEAM_MAYOR then return end
	if ply:Team() == TEAM_DETECTIVE then return end
	
	ply:StripWeapons()
	ply:SetModel('models/player/group01/male_02.mdl')
	
	for k,v in pairs(GAMEMODE.Config.DefaultWeapons) do
		local wep = ply:Give(v)
		if IsValid(wep) then
		  wep:SetVar("restricted_to_drop", true)
		end
	end

	for k,v in pairs(police_wep) do
		local wep = ply:Give(v)
		if IsValid(wep) then
	  		wep:SetVar("restricted_to_drop", true)
		end
	end

	ply:SetArmor(55)
	ply:ChatPrint('Для получения полного снаряжения, отправляйся в Полицейский Участок')
	
	end)
end)

hook.Add('canDropWeapon', 'restricted_to_drop', function(ply, weapon)
	if weapon:GetVar("restricted_to_drop") then return false end
end)
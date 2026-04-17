-- 17.04
AddCSLuaFile('shared.lua')
AddCSLuaFile('cl_init.lua')
include('shared.lua')

if not playerRobber then
	local playerRobber
end

local function isAllowed(ply)
	return BANK_CONFIG.Robbers[team.GetName(ply:Team())]
end

local function teamsCount()
	local gCount = 0
	local bCount = 0
	
	for k, v in pairs(player.GetAll()) do
		local team = team.GetName(v:Team())

		if BANK_CONFIG.Government[team] then
			gCount = gCount +1
		elseif BANK_CONFIG.Bankers[team] then
			bCount = bCount +1
		end
	end

	return BANK_CONFIG.MinGovernment <= gCount, BANK_CONFIG.MinBankers <= bCount
end

function ENT:Initialize()
	self:SetModel('models/props/cs_assault/moneypallet.mdl')
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.BankSiren = CreateSound(self, 'ambient/alarms/alarm1.wav')
	self.BankSiren:SetSoundLevel(40)
	
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
	    phys:EnableMotion(false)
	end
end

function ENT:Use(ply)
	local enoughCops, enoughBankers = teamsCount()
	
	if not isAllowed(ply) then
		DarkRP.notify(ply, 1, 3, "Ты не можешь начать ограбление за профессию "..team.GetName(ply:Team())..'!')
		return
	elseif ply:isArrested() then
		DarkRP.notify(ply, 1, 3, "Ты не можешь начать ограбление будучи арестован")
		return 
	elseif player.GetCount() < BANK_CONFIG.MinPlayers then
		DarkRP.notify(ply, 1, 3, "Недостаточно игроков")
		return 
	elseif not enoughCops then
		DarkRP.notify(ply, 1, 3, "Недостаточно полиции на сервере")
		return
	elseif not enoughBankers then
		DarkRP.notify(ply, 1, 3, "Недостаточно банкиров на сервере")
		return
	elseif playerRobber then
		DarkRP.notify(ply, 1, 3, 'Ограбление уже идет!')
		return
	elseif self:GetStatus() == 2 then
		DarkRP.notify(ply, 1, 3, 'Хранилище еще восстанавливается')
		return
	end

    for _, v in ipairs(player.GetAll()) do
        if v:isCP() then
            dMarkers.create(v, {title = "ОГРАБЛЕНИЕ БАНКА",text = ply:Nick().." начал ограбление банка!",color = Color(200, 0, 0),icon = 'icon16/money.png',pos = self:GetPos(), time = BANK_CONFIG.RobberyTime, type = 'police'}, 'npc/overwatch/radiovoice/riot404.wav')
        end
    end

	self:StartRobbery(ply)
end

function ENT:StartRobbery(ply)
	local name = ply:GetName()

	playerRobber = ply
	self.BankSiren:Play()
	self:SetStatus(1)
	self:SetNextAction(CurTime() +BANK_CONFIG.RobberyTime)
	ply:wanted(nil, 'ОГРАБЛЕНИЕ БАНКА', BANK_CONFIG.RobberyTime)
	DarkRP.notify(ply, 0, 3, 'Ты начал ограбление банка!')
	DarkRP.notify(ply, 0, 10, "Не отходи далеко от хранилища, чтобы не прервать ограбление")
	DarkRP.notify(ply, 0, 15, 'Во время ограбления банка, можно ставить исключительно барикады')
	DarkRP.notify(ply, 0, 20, "Без fading door и кейпадов, лабиринты также запрещены!")
	DarkRP.notifyAll(0, 10, name..' начал ограбление банка!')

	if not BANK_CONFIG.LoopSiren then
		timer.Simple(SoundDuration('ambient/alarms/alarm1.wav'), function()
			if self.BankSiren then
				self.BankSiren:Stop()
			end
		end)
	end

	hook.Add('Think', 'BankRS_RobberyThink', function()
		if self:GetNextAction() <= CurTime() then
			ply:addMoney(self:GetReward())
			DarkRP.notifyAll(0, 10, name..' завершил ограбление банка и получил $'..self:GetReward())
			self:SetReward(BANK_CONFIG.BaseReward)
			self:StartCooldown()
		else
			if ply:IsValid() then	
				if ply:isArrested() then
					ply:unWanted()
					self:StartCooldown()
					DarkRP.notifyAll(1, 5, name..' был арестован во время ограбления!')
	 		    elseif not isAllowed(ply) then
					self:StartCooldown()	
					DarkRP.notifyAll(1, 5, name..' сменил профессию во время ограбления!')
				elseif not ply:Alive() then
					ply:unWanted()
					self:StartCooldown()
					DarkRP.notifyAll(1, 5, name..' умер во время ограбления!')
	   	 		elseif ply:GetPos():DistToSqr(self:GetPos()) > BANK_CONFIG.MaxDistance ^2 then
					self:StartCooldown()
					DarkRP.notifyAll(1, 5, name..' вышел из зоны ограбления!')
				end
			else
				self:StartCooldown()
			end
		end
	end)
end

function ENT:StartCooldown()
	playerRobber = nil
	self.BankSiren:Stop()	
	self:SetStatus(2)
	self:SetNextAction(CurTime() +BANK_CONFIG.CooldownTime)
	hook.Remove('Think', 'BankRS_RobberyThink')
	timer.Simple(BANK_CONFIG.CooldownTime, function()
		if self:IsValid() then
			self:SetStatus(0)
		end
	end)
end

function ENT:OnRemove()
	if self.BankSiren:IsPlaying() then
		playerRobber = nil
		self.BankSiren:Stop()
		hook.Remove('Think', 'BankRS_RobberyThink')
	end
end

hook.Add('PlayerDeath', 'BankRS_RewardSavior', function(victim, inf, att)
	if victim ~= att and victim == playerRobber and att:IsPlayer() then
		att:addMoney(BANK_CONFIG.SaviorReward)
		DarkRP.notifyAll(0, 10, att:GetName()..' убил грабителя '..playerRobber:GetName()..' и остановил ограбление банка!')
		DarkRP.notify(att, 0, 5, 'Ты получил награду '..DarkRP.formatMoney(BANK_CONFIG.SaviorReward)..' за остановку ограбления!')
	end
end)

timer.Create('BankRS_ApplyInterest', BANK_CONFIG.InterestTime, 0, function()
	for k, v in pairs(ents.FindByClass('bank_vault')) do
		if v:GetStatus() == 0 then
			local value = v:GetReward()

			if value ~= BANK_CONFIG.MaxReward then
				v:SetReward(math.Clamp(value +BANK_CONFIG.Interest, 0, BANK_CONFIG.MaxReward))
			end
		end
	end
end)
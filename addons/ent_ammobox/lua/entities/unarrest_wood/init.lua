-- 17.04
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString('sell_unarrest')

net.Receive('sell_unarrest', function(len, ply)
	if not ply:canAfford(350000) then DarkRP.notify(ply, 1, 3, 'Недостаточно средств') return end
	ply:addMoney(-350000)
	ply:unArrest()
	DarkRP.notifyAll(0, 5, ply:Nick()..' вышел досрочно из тюрьмы за 350.000$')
end)

function ENT:Initialize()
	self:SetModel('models/props/cs_office/offcorkboarda.mdl')
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
end

function ENT:Use(ply)
   ply:ConCommand('unarrest_sell') 
end
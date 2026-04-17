-- 17.04
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- Sets what model to use
	self:SetModel( "models/cocn.mdl" )

	-- Physics stuff
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	-- Make prop to fall on spawn
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

local text = "Заебись! Класс! Супер!"

function ENT:Use(activator,caller)
	activator:Say(text)
	activator:SetJumpPower(300)
  activator:ChatPrint("Чувствую прилив сил в ногах..")
	timer.Simple(30, function()
    if not IsValid(activator) then return end
    if not activator:Alive() then return end
    activator:SetJumpPower(100)
	end)
	
	self:Remove()
end


-- t.me/urbanichka
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- Sets what model to use
	self:SetModel( "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl" )

	-- Physics stuff
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	-- Make prop to fall on spawn
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

local text = "СНУП О ВЕЛИКИЙ ДАЙ ЕЩЕ!"

function ENT:Use(activator,caller)
	activator:SetJumpPower(9999)
	activator:SetWalkSpeed(9999)
	self:Remove()
	
	timer.Simple(10, function()
	    if not IsValid(activator) then return end
	    if not activator:Alive() then return end
	    activator:Kill()
	end)
end


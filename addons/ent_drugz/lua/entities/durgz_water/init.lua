-- 17.04
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- Sets what model to use
	self:SetModel( "models/drug_mod/the_bottle_of_water.mdl" )

	-- Physics stuff
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	-- Make prop to fall on spawn
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end
--called when you use it (after it sets the high visual values and removes itself already)
function ENT:Use(activator,caller)
	activator:SetHealth(100)
	self:Remove()
end

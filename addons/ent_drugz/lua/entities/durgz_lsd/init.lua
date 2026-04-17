-- 17.04
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- Sets what model to use
	self:SetModel( "models/cocn.mdl" )

	-- Sets what color to use
	self:SetColor( Color( 200, 255, 200 ) )

	-- Physics stuff
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	-- Make prop to fall on spawn
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end


function ENT:Use(activator, caller)
    activator:Kill()
	self:Remove()
end
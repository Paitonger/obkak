-- t.me/urbanichka
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    
	self:SetModel( "models/jaanus/aspbtl.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	local phys = self:GetPhysicsObject()
	
	if ( IsValid( phys ) ) then phys:Wake() end
end

function ENT:Use(activator,caller)
	activator:Kill()
	self:Remove()
end

function ENT:Think()
end
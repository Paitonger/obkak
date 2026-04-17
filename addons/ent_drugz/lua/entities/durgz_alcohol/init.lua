-- t.me/urbanichka
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    
	self:SetModel( "models/props_junk/PopCan01a.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	local phys = self:GetPhysicsObject()
	
	if ( IsValid( phys ) ) then phys:Wake() end
end


function ENT:Use(activator,caller)
	activator:ChatPrint('Скорость бега увеличена с '..activator:GetRunSpeed()..' до '..activator:GetRunSpeed() + 5)
	activator:SetRunSpeed(activator:GetRunSpeed()+5)
	activator:EmitSound('vo/trainyard/male01/cit_window_use0'..math.random(1,4)..'.wav')
	self:Remove()
end

function ENT:Think()
end
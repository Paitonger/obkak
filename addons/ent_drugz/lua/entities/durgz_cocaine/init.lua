-- t.me/urbanichka
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/cocn.mdl" )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

function ENT:Use(activator,caller)
    if activator:GetNWBool("CocaineKill") then activator:Kill() return end
    activator:SetRunSpeed(1000)
    timer.Simple(30, function()
       if not IsValid(activator) then return end
       if not activator:Alive() then return end
       activator:SetRunSpeed(240)
    end)
    
    activator:SetNWBool("CocaineKill", true)
	self:Remove()
end

hook.Add("PlayerDeath", "disable_nwbool", function(v, i, a)
    v:SetNWBool("CocaineKill", false)
end)
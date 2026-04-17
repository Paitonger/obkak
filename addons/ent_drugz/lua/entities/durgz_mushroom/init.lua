-- 17.04
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/cocn.mdl" )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	-- Make prop to fall on spawn
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

local text = "Ебать я охуевший."

function ENT:Use(activator,caller)
	activator:SetModelScale(2)
	activator:SetHealth(250)
	activator:SetArmor(150)

  timer.Simple(30, function()
    if not IsValid(activator) then return end
    if not activator:Alive() then return end
    activator:SetHealth(100)
    activator:SetArmor(0)
    activator:SetModelScale(1)
  end)

	activator:Say(text)
	self:Remove()
end

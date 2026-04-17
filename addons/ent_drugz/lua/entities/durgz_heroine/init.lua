-- t.me/urbanichka
--I know the folder "heroine" isn't right but I wanted the files to overwrite instead of having two files, heroine and heroin. So I just kept it as-is.

AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel( "models/katharsmodels/syringe_out/syringe_out.mdl" )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

local text = "КОКА ВЕЗЕЛИТ КАК ВЗИГДА, Я АБЗАЛЮДНА ЗБАГОЕН"

function ENT:Use(activator,caller)
  activator:Say(text)
  activator:SetHealth(1)
  activator:ChatPrint("ПРЫГАЙ!!!!!!!!!!")
  activator:SetJumpPower(1000)
	self:Remove()
end

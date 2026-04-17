-- t.me/urbanichka
AddCSLuaFile()

SWEP.Base				= "weapon_base"

SWEP.PrintName			= "Ghost Weapon"		
SWEP.Author				= "Slade Xanthas"
SWEP.Category			= "Запрещено"
SWEP.Instructions		= "ПКМ - Полет | ЛКМ - Удар | R - Наградить второй жизнью чувачка напротив"
SWEP.Slot				= 1
SWEP.SlotPos			= 0
		
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.Spawnable			= true
SWEP.AdminOnly			= false

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Delay				= 5
SWEP.Primary.ClipSize			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo				= "none"

SWEP.Secondary.Delay			= 1
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic		= false
SWEP.Secondary.Ammo				= "none"

SWEP.HoldType = "slam"
SWEP.ThrownHoldType = "normal"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = ""

function SWEP:PrimaryAttack()
	if SERVER then
	local ply = self:GetOwner()
	local halloween = ents.Create('bonbon01')
	halloween:SetPos(ply:GetPos())
	halloween:Spawn()
	ply:EmitSound('ambient/levels/canals/shore1.wav')
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )

	timer.Simple(30, function()
		if not IsValid(halloween) then return end
		halloween:Remove()
	end) 

	end
end

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()
	if ply:GetMoveType() == MOVETYPE_FLY then
		ply:SetMoveType(MOVETYPE_WALK)
	else
		ply:SetMoveType(MOVETYPE_FLY)
	end
end

function SWEP:Reload()

end
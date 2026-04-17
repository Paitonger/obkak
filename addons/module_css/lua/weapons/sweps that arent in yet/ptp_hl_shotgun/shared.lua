-- 17.04
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Shotgun"			
	SWEP.Author				= "Counter-Strike: ADV"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "Shotgun"
	
	killicon.AddFont( "ptp_hl_shotgun", "TextKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "ptp_shotgun_base"
SWEP.Category			= "Half-Life 2: PTP"
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.UseHands			= true
SWEP.ViewModel			= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Primary.Sound			= Sound( "weapon_shotgun.single" )
SWEP.Primary.Reload 		= Sound("Weapon_SMG1.Reload")
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 28
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 45
SWEP.Primary.Delay			= 0.07
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 100
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "smg2"

SWEP.IronSightsPos = Vector(-6.4, -2, 1.03)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.AimSightsPos = Vector(-6.4, -2, 1.03)
SWEP.AimSightsAng = Vector(0, 0, 0)
SWEP.DashArmPos = Vector(4.355, -7.206, -0.681)
SWEP.DashArmAng = Vector(-20.965, 45.062, -20.664)


--Extras
SWEP.ReloadHolster		= 1.3
SWEP.ReloadSound		= true
-- Accuracy
SWEP.CrouchCone				= 0.01 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.02 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.025 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.015 -- Accuracy when we're standing still
SWEP.Delay				= 0.07
SWEP.Recoil				= 2
SWEP.RecoilZoom			= 0.7
SWEP.IronSightsCone			= 0.01

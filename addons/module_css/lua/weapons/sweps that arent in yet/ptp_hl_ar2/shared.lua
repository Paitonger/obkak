-- t.me/urbanichka
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "AR2"			
	SWEP.Author				= "Counter-Strike: ADV"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "AR2"
	
	killicon.AddFont( "ptp_hl_smg", "TextKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "ptp_scoped_base"
SWEP.Category			= "Half-Life 2: PTP"
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.UseHands			= true
SWEP.ViewModel			= "models/weapons/c_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Primary.Sound			= Sound( "weapon_ar2.single" )
SWEP.Primary.Reload 		= Sound("Weapon_ar2.Reload")
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 35
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.09
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "smg2"

SWEP.IronSightsPos = Vector(-5.82, -2, 1.25)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.AimSightsPos = Vector(-5.82, -2, 1.25)
SWEP.AimSightsAng = Vector(0, 0, 0)
SWEP.DashArmPos = Vector(4.355, -7.206, -0.681)
SWEP.DashArmAng = Vector(-20.965, 45.062, -20.664)


--Extras
SWEP.ReloadHolster		= 1.3
SWEP.ReloadSound		= true
-- Weapon Variations
SWEP.UseScope				= true -- Use a scope instead of iron sights.
SWEP.ScopeScale 			= 0.55 -- The scale of the scope's reticle in relation to the player's screen size.
SWEP.ScopeZoom				= 2
SWEP.CrossHair				= true
--Only Select one... Only one.
SWEP.ScopeReddot		= true
SWEP.ScopeNormal		= false
SWEP.ScopeMs			= false
SWEP.BoltAction			= false --Self Explanatory
-- Accuracy
SWEP.CrouchCone				= 0.01 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.02 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.025 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.015 -- Accuracy when we're standing still
SWEP.Delay				= 0.09
SWEP.Recoil				= 1
SWEP.RecoilZoom			= 0.7
SWEP.IronSightsCone			= 0.01

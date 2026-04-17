-- t.me/urbanichka
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end
///////////////////////////////////////////////////////////
///														///
///				Project Start: 11/11/13					///
///														///
///////////////////////////////////////////////////////////
/*---------------------------------------------------------
	Client Variables
---------------------------------------------------------*/
if ( CLIENT ) then

	SWEP.PrintName			= "SWEPNAME"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "" --Text Font
	SWEP.IconLetterCSS		= "" --For Css Font
	SWEP.DrawCrosshair		= false
	SWEP.DrawAmmo			= true
	SWEP.CSMuzzleFlashes	= true
	
	killicon.AddFont( "weapon_cs_ak47_gb", "TextKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	surface.CreateFont("TextKillIcons", { font="Roboto-Medium", weight="500", size=ScreenScale(13),antialiasing=true,additive=true })
	surface.CreateFont("TextSelectIcons", { font="Roboto-Medium", weight="500", size=ScreenScale(20),antialiasing=true,additive=true })
	surface.CreateFont("CSKillIcons", { font="csd", weight="500", size=ScreenScale(30),antialiasing=true,additive=true })
	surface.CreateFont("CSSelectIcons", { font="csd", weight="500", size=ScreenScale(60),antialiasing=true,additive=true })

end
/*---------------------------------------------------------
	The Layout...
---------------------------------------------------------*/
SWEP.Category			= "Hello"
SWEP.ViewModelFlip		= true

SWEP.Spawnable			= false 	-- Delete this comment and change these to true
SWEP.AdminSpawnable		= false		-- If you don't you can't spawn the swep :(

SWEP.Base				= "ptp_weapon_base"
SWEP.ViewModel			= "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.ViewModelFOV		= 80

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Primary.Sound			= Sound( "" )
SWEP.SilencedSound			= Sound( "" ) --This is for silencers. Dont bite me, I know its really called a suppressor.
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 34
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= 300
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( 3.4, -3, 1.2 )
SWEP.IronSightsAng 		= Vector( 0.5, 0.0, 0 )

--Extras
SWEP.MuzzleEffect			= "lee_muzzle_rifle"	-- Muzzle attachments should not be messed with
SWEP.MuzzleAttachment			= "1"			-- There's only one anyways
SWEP.MuzzleAttachmentTrue		= true		-- Keep it true
SWEP.TracerShot				= 3		-- On what shot should there be a tracer?
SWEP.TakeAmmoOnShot			= 1     -- How many rounds should we take per shot? Typically leave this at one.
SWEP.BulletForce			= 10	-- The force a bullet has on a prop
SWEP.Silenceable			= false		-- If the model supports a silencer
SWEP.SilenceHolster			= 0		-- The timing for silencer animation
SWEP.ZoomFOV				= 65	-- Fov for when we're aiming
SWEP.CSSZoom				= false	-- This is for using Zoom Delays. Example the AUG zoom in CSS
SWEP.MPrecoil				= 1		-- Changes the amount of view punch in multiplayer
SWEP.ReloadHolster			= 1		-- How long should we wait before allowing think when reloading
SWEP.ReloadSound			= false	-- This has only been found to be used on HL2 weapons

-- Accuracy
SWEP.CrouchCone				= 0.01 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.02 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.025 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.015 -- Accuracy when we're standing still
SWEP.IronSightsCone			= 0.006 -- Accuracy when we're aiming
SWEP.Delay				= 0.08	-- Delay For Not Zoom
SWEP.Recoil				= 1	-- Recoil For not Aimed
SWEP.RecoilZoom				= 0.3	-- Recoil For Zoom



/*---------------------------------------------------------
	Draw a CrossHair! 
---------------------------------------------------------*/

//Ripped from LeErOy NeWmAn and Worshipper, Don't tell them shhh

ptp_crosshair_r 		= CreateClientConVar("ptp_crosshair_r", 255, true, false)		// Red
ptp_crosshair_g 		= CreateClientConVar("ptp_crosshair_g", 255, true, false)		// Green
ptp_crosshair_b 		= CreateClientConVar("ptp_crosshair_b", 255, true, false)		// Blue
ptp_crosshair_a 		= CreateClientConVar("ptp_crosshair_a", 200, true, false)		// Alpha
ptp_crosshair_l 		= CreateClientConVar("ptp_crosshair_l", 0, true, false)		// Length
ptp_crosshair_gap 		= CreateClientConVar("ptp_crosshair_gap", 0, true, false)		// Gap
ptp_crosshair_t 		= CreateClientConVar("ptp_crosshair_t", 1, true, false)		// Enable/Disable
ptp_crosshair_thin 		= CreateClientConVar("ptp_crosshair_thin", 1, true, false)		// Enable/Disable
ptp_crosshair_static	= CreateClientConVar("ptp_crosshair_static", 0, true, false)		// Enable/Disable
ptp_crosshair_hl2 		= CreateClientConVar("ptp_crosshair_hl2", 0, true, false)		// Enable/Disable

SWEP.CrosshairScale = 1
function SWEP:DrawHUD()

	if ptp_crosshair_t:GetInt()  == 0 then return end

	if ptp_crosshair_hl2:GetInt()  == 0 then
	
	self.DrawCrosshair = false
	// Make Sure this shit goes away
	
	local DisableDashing = false
	
		if GetConVar("sv_ptp_dashing_disable") == nil then
		DisableDashing = false
		else
		DisableDashing = GetConVar("sv_ptp_dashing_disable"):GetBool()
		end
		
	if self.Owner:KeyDown(IN_SPEED) and not DisableDashing then return end
	//Remove CrossHair on Sprint
	

	//Remove on IronSights
	
	local x = ScrW() * 0.5
	local y = ScrH() * 0.5
	local scalebywidth = (ScrW() / 1024) * 5

	local scale = 2
	local canscale = true

	if ptp_crosshair_static:GetInt() == 0 then
	scale = scalebywidth * self.Primary.Cone + (self:GetNWFloat("SprayAdditive")*0.05)
	else
	scale = 0.05
	end
	surface.SetDrawColor(ptp_crosshair_r:GetInt(), ptp_crosshair_g:GetInt(), ptp_crosshair_b:GetInt(), ptp_crosshair_a:GetInt())

local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	--scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

	local dist = math.abs(self.CrosshairScale - scale)
	self.CrosshairScale = math.Approach(self.CrosshairScale, scale, FrameTime() * 2 + dist * 0.05)

	

	if (ptp_crosshair_thin:GetInt() == 1) then
		local gap = 30 * self.CrosshairScale
		local length = gap + 15 * self.CrosshairScale
		surface.DrawLine(x - (length + ptp_crosshair_l:GetInt()), y, x - (gap +ptp_crosshair_gap:GetInt()), y)
		surface.DrawLine(x + (length + ptp_crosshair_l:GetInt()), y, x + (gap +ptp_crosshair_gap:GetInt()), y)
		surface.DrawLine(x, y - (length + ptp_crosshair_l:GetInt()), x, y - (gap +ptp_crosshair_gap:GetInt()))
		surface.DrawLine(x, y + (length + ptp_crosshair_l:GetInt()), x, y + (gap +ptp_crosshair_gap:GetInt()))
	else
		local gap = 40 * self.CrosshairScale
		local length = gap + 6
		if ptp_crosshair_out:GetInt() == 1 then
		surface.SetDrawColor(0, 0, 0, ptp_crosshair_a:GetInt())
		surface.DrawRect( x -(gap + ptp_crosshair_gap:GetInt()) - ( ptp_crosshair_l:GetInt() + 12), y-3 - (ptp_crosshair_w:GetInt()), 2 + (ptp_crosshair_l:GetInt() + 12), 6 + (ptp_crosshair_w:GetInt() * 2) )
		surface.DrawRect( x-2+( gap +ptp_crosshair_gap:GetInt()), y-3- (ptp_crosshair_w:GetInt()), 2 + ( ptp_crosshair_l:GetInt() + 12), 6+ (ptp_crosshair_w:GetInt() * 2) )
		surface.DrawRect( x-3- (ptp_crosshair_w:GetInt()), y- 4 -( ptp_crosshair_gap:GetInt()) - (gap + ptp_crosshair_l:GetInt() + 8 ), 6 + (ptp_crosshair_w:GetInt() * 2), 14 + ( ptp_crosshair_l:GetInt() ))
		surface.DrawRect( x-3- (ptp_crosshair_w:GetInt()), y-2+ (gap + ptp_crosshair_gap:GetInt()), 6 + (ptp_crosshair_w:GetInt() * 2), 14 + ( ptp_crosshair_l:GetInt() ) )
		end
	
	surface.SetDrawColor(ptp_crosshair_r:GetInt(), ptp_crosshair_g:GetInt(), ptp_crosshair_b:GetInt(), ptp_crosshair_a:GetInt())

	surface.DrawRect( x - 2 -( gap + ptp_crosshair_gap:GetInt()) - ( ptp_crosshair_l:GetInt() + 8), y-1 - (ptp_crosshair_w:GetInt()), 2 + (ptp_crosshair_l:GetInt() + 8), 2 + (ptp_crosshair_w:GetInt() * 2) )
	surface.DrawRect( x+( gap + ptp_crosshair_gap:GetInt()), y-1- (ptp_crosshair_w:GetInt()), 2 + ( ptp_crosshair_l:GetInt() + 8), 2+ (ptp_crosshair_w:GetInt() * 2) )
	surface.DrawRect( x-1- (ptp_crosshair_w:GetInt()), y- 10 -( ptp_crosshair_gap:GetInt()) - (gap + ptp_crosshair_l:GetInt() ), 2 + (ptp_crosshair_w:GetInt() * 2), 10 + ( ptp_crosshair_l:GetInt() ))
	surface.DrawRect( x-1- (ptp_crosshair_w:GetInt()), y+ (gap + ptp_crosshair_gap:GetInt()), 2 + (ptp_crosshair_w:GetInt() * 2), 10 + ( ptp_crosshair_l:GetInt() ) )
	//surface.DrawLine(x-2, y, x+2, y)
	//surface.DrawLine(x, y-2, x, y+2)
	end
	else

	
	if self.Owner:KeyDown(IN_SPEED) then 
		self.DrawCrosshair = false
		else
		self.DrawCrosshair = true
	end
	end
end
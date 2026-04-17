-- t.me/urbanichka

AddCSLuaFile()

SWEP.PrintName = "Power Fists"
SWEP.Author = "WayZer"
SWEP.Purpose = "Кулаки SpiderMan'a."
SWEP.Category = "Запрещено"
SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.HitDistance = 48

local SwingSound = Sound( "WeaponFrag.Throw" )
local HitSound = Sound( "Flesh.ImpactHard" )

local function lookingAtLockable(ply, ent)
    local eyepos = ply:EyePos()
    return IsValid(ent)             and
        ent:isKeysOwnable()         and
        not ent:getKeysNonOwnable() and
        (
            ent:isDoor()    and eyepos:Distance(ent:GetPos()) < 65
            or
            ent:IsVehicle() and eyepos:Distance(ent:NearestPoint(eyepos)) < 100
        )

end

function SWEP:Initialize()

	self:SetHoldType( "fist" )

end

function SWEP:SetupDataTables()

	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )

end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )

end

function SWEP:PrimaryAttack( right )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local anim = "fists_left"
	if ( right ) then anim = "fists_right" end
	if ( self:GetCombo() >= 2 ) then
		anim = "fists_uppercut"
	end

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingSound )

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )

	self:SetNextPrimaryFire( CurTime() + 0.9 )
	self:SetNextSecondaryFire( CurTime() + 0.9 )

	if SERVER then

	local job = {
		TEAM_SHAZAM,
		TEAM_BLACKSS,
		TEAM_BANTANK
	}

	local tr = self.Owner:GetEyeTrace()
	if tr.Entity:GetClass() == "prop_door_rotating" and table.HasValue (job, self.Owner:Team()) then
		local ent = tr.Entity
    if ent:GetPos():Distance(self.Owner:GetShootPos()) > 100 then return end
		ent:SetKeyValue("Speed", "500")
		ent:SetKeyValue("Open Direction", "Both directions")
		ent:SetKeyValue("opendir", "0")
		ent:Fire("unlock", "", .01)
		ent:Fire("openawayfrom", "bashingpl" .. self.Owner:EntIndex(), .01)
		ent:EmitSound("ambient/materials/door_hit1.wav", 100, math.random(90, 110))

		timer.Simple(0.3, function()
			if IsValid(ent) then
				ent:SetKeyValue("Speed", "100")
			end
		end)
	end

	end
	
	local trace = self:GetOwner():GetEyeTrace()

    if not lookingAtLockable(self:GetOwner(), trace.Entity) then return end

    self:SetNextSecondaryFire(CurTime() + 0.3)

    if CLIENT then return end

    if self:GetOwner():canKeysUnlock(trace.Entity) then
        trace.Entity:keysUnLock() -- Unlock the door immediately so it won't annoy people
    elseif trace.Entity:IsVehicle() then
        DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
    end
end

function SWEP:SecondaryAttack()

	self:PrimaryAttack( true )

end

function SWEP:DealDamage()

	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())

	self.Owner:LagCompensation( true )

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

	if ( !IsValid( tr.Entity ) ) then
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	-- We need the second part for single player because SWEP:Think is ran shared in SP
	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		self:EmitSound( HitSound )
	end

	local hit = false

	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()

		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )

		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( math.random( 100, 150 ) )

		if ( anim == "fists_left" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 + self.Owner:GetForward() * 9998 ) -- Yes we need those specific numbers
		elseif ( anim == "fists_right" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * -4912 + self.Owner:GetForward() * 9989 )
		elseif ( anim == "fists_uppercut" ) then
			dmginfo:SetDamageForce( self.Owner:GetUp() * 5158 + self.Owner:GetForward() * 10012 )
			dmginfo:SetDamage( math.random( 100, 150 ) )
		end

		tr.Entity:TakeDamageInfo( dmginfo )
		hit = true

	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
		end
	end

	if ( SERVER ) then
		if ( hit && anim != "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end

	self.Owner:LagCompensation( false )

end

function SWEP:OnDrop()

	self:Remove() -- You can't drop fists

end

function SWEP:Deploy()

	local speed = GetConVarNumber( "sv_defaultdeployspeed" )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
	vm:SetPlaybackRate( speed )

	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() / speed )
	self:SetNextSecondaryFire( CurTime() + vm:SequenceDuration() / speed )
	self:UpdateNextIdle()

	if ( SERVER ) then
		self:SetCombo( 0 )
	end

	return true

end

function SWEP:GetFallDamage(pl, speed)
	if self.Owner == pl and self.Owner:GetActiveWeapon() == self then
	return 0
	end
end

function SWEP:Initialize()
	if SERVER then
	hook.Add ("GetFallDamage", self, self.GetFallDamage)
	end
	self:SetHoldType( "fist" )
end

function SWEP:Think()

	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if ( idletime > 0 && CurTime() > idletime ) then

		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )

		self:UpdateNextIdle()

	end

	local meleetime = self:GetNextMeleeAttack()

	if ( meleetime > 0 && CurTime() > meleetime ) then

		self:DealDamage()

		self:SetNextMeleeAttack( 0 )

	end

	if ( SERVER && CurTime() > self:GetNextPrimaryFire() + 0.1 ) then

		self:SetCombo( 0 )

	end

end

local cooldown = 0

function SWEP:Reload()
	if CLIENT then return end
	local ply = self:GetOwner()
	if ply:Team() == TEAM_BLACKSS then

	if CurTime() < cooldown then return end

		local getpos = ply:GetPos()
		local data = EffectData()
		data:SetOrigin(getpos)
		util.BlastDamage(ply,ply,getpos,500,90)
  		util.Effect("StunstickImpact", data)
  		ply:EmitSound("ambient/explosions/explode_"..math.random(7,8)..".wav")

    --	ply:Ignite(10,350)

	cooldown = CurTime() + 20
	
	end
end

hook.Add('EntityTakeDamage', 'ignorefiredamage', function(ent, dmg)
	
	if not IsValid(ent) then return end
	-- 8
	if (ent:IsPlayer() and dmg:IsDamageType(64)) then 
		if (ent:Team() == TEAM_BLACKSS) then
			return true
		end
	end

end)
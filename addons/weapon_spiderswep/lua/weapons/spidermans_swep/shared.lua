-- t.me/urbanichka

SWEP.Author			= "chelog"
SWEP.Category 		= "Запрещено"
SWEP.Purpose		= "Allows you to be Spider-Man"
SWEP.Instructions	= "Silent Edition, without startup music. Left click to shoot web and then jump!"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType 			= "normal"
SWEP.PrintName			= "Spider-Mod SWEP [SE]"
SWEP.Slot				= 2
SWEP.SlotPos			= 0
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.ViewModel			= "models/weapons/c_sw_free_hands.mdl"
SWEP.WorldModel			= "models/weapons/c_sw_free_hands.mdl"

SWEP.Beam = {}
SWEP.Tr = {}
SWEP.dt = {}
SWEP.startTime = {}
SWEP.endTime = {}
SWEP.speed = {}
SWEP.addVel = Vector()

function SWEP:Initialize()

    self:SetWeaponHoldType( self.HoldType )

end

function SWEP:Think()

	if (!self.Owner || self.Owner == NULL) then return end

	if ( self.Owner:KeyPressed( IN_ATTACK ) ) then

		self:StartAttack( 1 )

	elseif SERVER and ( self.Owner:KeyDown( IN_ATTACK ) ) then

		self:UpdateAttack( 1 )

	elseif SERVER and ( self.Owner:KeyReleased( IN_ATTACK ) ) then

		self:EndAttack( 1, true )

	end

	if ( self.Owner:KeyPressed( IN_ATTACK2 ) ) then

		self:StartAttack( 2 )

	elseif SERVER and ( self.Owner:KeyDown( IN_ATTACK2 ) ) then

		self:UpdateAttack( 2 )

	elseif SERVER and ( self.Owner:KeyReleased( IN_ATTACK2 ) ) then

		self:EndAttack( 2, true )

	end

	self.Owner:SetVelocity( self.addVel )
	self.addVel = Vector()

end

function SWEP:DoTrace( num, endpos )
	local trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = trace.start + (self.Owner:GetAimVector() * 14096)
		if(endpos) then trace.endpos = (endpos - self.Tr[num].HitNormal * 7) end
		trace.filter = { self.Owner, self.Weapon }

	self.Tr[num] = nil
	self.Tr[num] = util.TraceLine( trace )
end

function SWEP:StartAttack( num )
	local gunPos = self.Owner:GetShootPos()
	local disTrace = self.Owner:GetEyeTrace()
	local hitPos = disTrace.HitPos

	-- local x = (gunPos.x - hitPos.x)^2;
	-- local y = (gunPos.y - hitPos.y)^2;
	-- local z = (gunPos.z - hitPos.z)^2;
	-- local distance = math.sqrt(x + y + z);
	--
	-- local distanceCvar = GetConVarNumber("rope_distance")
	-- inRange = false
	-- if distance <= distanceCvar then
	-- 	inRange = true
	-- end


	if (SERVER) then

		if (!self.Beam[num]) then
			self.Beam[num] = ents.Create( "rope" )
				self.Beam[num]:SetPos( self.Owner:GetShootPos() )
			self.Beam[num]:Spawn()
		end

		self.Beam[num]:SetParent( self.Owner )
		self.Beam[num]:SetOwner( self.Owner )

	end

	self:DoTrace( num )
	self.speed[num] = 10000
	self.startTime[num] = CurTime()
	self.endTime[num] = CurTime() + self.speed[num]
	self.dt[num] = -1

	if (SERVER && self.Beam[num]) then
		self.Beam[num]:GetTable():SetEndPos( self.Tr[num].HitPos )
		self:UpdateAttack()
	end

end

function SWEP:UpdateAttack( num )

	if not self.Owner:IsLagCompensated() then
		self.Owner:LagCompensation( true )
	end

	if not self.Tr[num] then return end
	if (!endpos) then endpos = self.Tr[num].HitPos end

	if (SERVER && self.Beam[num]) then
		self.Beam[num]:GetTable():SetEndPos( endpos )
	end

	lastpos = endpos

	if ( self.Tr[num].Entity:IsValid() ) then

	endpos = self.Tr[num].Entity:GetPos()
			if ( SERVER && self.Beam[num] ) then
			self.Beam[num]:GetTable():SetEndPos( endpos )
			end

	end

	local vVel = (endpos - self.Owner:GetPos())
	local Distance = endpos:Distance(self.Owner:GetPos())

	local et = (self.startTime[num] + (Distance/self.speed[num]))
	if(self.dt[num] != 0) then
		self.dt[num] = (et - CurTime()) / (et - self.startTime[num])
	end
	if(self.dt[num] < 0) then
		self.dt[num] = 0
	end

	if(self.dt[num] == 0) then
		zVel = self.Owner:GetVelocity().z
		vVel = vVel:GetNormalized()*(math.Clamp(Distance,0,7))*10
		if( SERVER ) then
			local gravity = GetConVarNumber("sv_Gravity")
			vVel:Add(Vector(0,0,(gravity/100)*3))
			if(zVel < 0) then
				vVel:Sub(Vector(0,0,zVel/100))
			end
			self.addVel = self.addVel + vVel
		end
	end

	endpos = nil

	self.Owner:LagCompensation( false )

end

function SWEP:EndAttack( num, shutdownsound )

	if ( CLIENT ) then return end
	if ( !self.Beam[num] ) then return end

	self.Beam[num]:Remove()
	self.Beam[num] = nil

end

function SWEP:Attack2()



end

function SWEP:Holster()
	self:EndAttack( 1, false )
	self:EndAttack( 2, false )
	return true
end

function SWEP:OnRemove()
	self:EndAttack( 1, false )
	self:EndAttack( 2, false )
	return true
end


function SWEP:PrimaryAttack()
	self.Weapon:EmitSound("web/webfire.wav")
end

function SWEP:SecondaryAttack()
	self.Weapon:EmitSound("web/webfire.wav")
end

local weball = 0

function SWEP:Reload()
	if CLIENT then return end

  if ( !self.Owner:KeyPressed( IN_RELOAD ) ) then return end
  if weball >= 10 then return end

	local ply = self:GetOwner()
	local tr = ply:GetEyeTrace().HitPos

	local web = ents.Create('cobweb')
	web:SetPos(tr)
	web:Spawn()
	weball = weball + 1
	

	timer.Simple(20, function()
		if not IsValid(web) then 
			weball = weball - 1 
			return
		end

		web:Remove()
		weball = weball - 1 

	end)

end
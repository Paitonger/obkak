-- t.me/urbanichka
	
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )
local angles = include('positions.lua')
SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
local RapeLength = SWEP.RapeLength
local SoundDelay = SWEP.SoundDelay
local ThrustVel = 750


local victimPos = {

	Vector( 20, 20, 50 ),
	Vector( 30, -30, 30 ),
	Vector( 30, 30, 24 ),
	Vector( 30, 30, 14 ),
	Vector( 30, 30, 4 ),
	Vector( 30, -30, 7 ),
	Vector( 30, -30, 1 ),
	Vector( -30, -30, 22 ),
	Vector( -30, -30, 4 ),
	Vector( 30, -30, 18 ),
	Vector( -30, 30, 22 ),
	Vector( -30, 30, 4 ),
	Vector( -30, 30, 6 ),
	Vector( -30, -30, 6 ),

}

local attackerPos = {

	Vector( -0.65728759765625, 0.377197265625, 30.7626953125 ),
	Vector( 9.2244873046875, -3.9486083984375, 35.96484375 ),
	Vector( 6.1197509765625, 10.176849365234, 30.6552734375 ),
	Vector( 8.9208984375, 12.130462646484, 20.0087890625 ),
	Vector( 11.781127929688, 14.134094238281, 9.0712890625 ),
	Vector( 10.643859863281, -13.228057861328, 29.0009765625 ),
	Vector( 15.782470703125, -6.8009948730469, 20.9951171875 ),
	Vector( -9.7853393554688, -4.5965576171875, 24.3857421875 ),
	Vector( -11.373352050781, -7.4108276367188, 6.8203125 ),
	Vector( 13.504028320313, 4.9801635742188, 34.6708984375 ),
	Vector( -11.517456054688, 2.9996948242188, 25.9482421875 ),
	Vector( -14.434143066406, 11.57861328125, 10.537109375 ),
	Vector( -30.881225585938, 10.939605712891, 9.0634765625 ),
	Vector( -26.714416503906, -13.074645996094, 9.19921875 ),

}


local sounds = {
	"player/crit_death1.wav",
	"player/crit_death2.wav",
	"player/crit_death3.wav",
	"player/crit_death4.wav",
	"player/crit_death5.wav",
	"bot/come_to_papa.wav",
	"bot/im_pinned_down.wav",
	"bot/oh_man.wav",
	"bot/yesss.wav",
	"bot/pain4",
	"bot/pain5",
	"bot/pain8",
	"bot/pain9",
	"bot/pain10",
	"bot/stop_it.wav",
	"bot/help.wav",
	"bot/i_could_use_some_help.wav",
	"bot/i_could_use_some_help_over_here.wav",
	"bot/they_got_me_pinned_down_here.wav",
	"bot/this_is_my_house.wav",
	"bot/need_help.wav",
	"bot/i_am_dangerous.wav",
	"bot/yikes.wav",
	"noo.wav",
	"bot/whos_the_man.wav",
	"bot/hang_on_im_coming.wav",
	"hostage/hpain/hpain1.wav",
	"hostage/hpain/hpain2.wav",
	"hostage/hpain/hpain3.wav",
	"hostage/hpain/hpain4.wav",
	"hostage/hpain/hpain5.wav",
	"hostage/hpain/hpain6.wav",
	"vo/k_lab/al_youcoming.wav",
	"vo/k_lab/kl_ahhhh.wav",
}

local sounds3 = {
	"physics/body/body_medium_break2.wav",
	"physics/body/body_medium_break3.wav",
	"physics/body/body_medium_break4.wav",
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard4.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
}

local InProgress = false

concommand.Add('RAPEDEMBITCHEZ', function (ply, cmd, args)
	if ply.rapeCooldown and ply.rapeCooldown > CurTime() then return end

	if !ply or !ply:IsValid() then return end

	if not ply:HasWeapon( "weapon_rape" ) then return end
	if ply:Team() ~= TEAM_NASILNIK then return end

	local plyAttacker = ply
	local plyAttackerPos = plyAttacker:GetPos()
	
	local plyVictim = plyAttacker:GetEyeTrace().Entity
	if !plyVictim or plyVictim == nil or !plyVictim:IsValid() then return end
	if !plyVictim or !plyVictim:IsValid() or !plyVictim:IsPlayer() then return end

	if plyAttacker:GetPos():DistToSqr(plyVictim:GetPos())^(1/2) > 200 then return end

	InProgress = true

	local plyVictimHealth = plyVictim:Health()
	local plyVictimPos = plyVictim:GetPos()
	local VictimType = 1
	if plyVictim:IsNPC() then
		VictimType = 2
	elseif plyVictim:GetClass() == "prop_ragdoll" then
		VictimType = 3
	end
	
	plyAttacker.Raping = true
	
	plyAttacker:StripWeapons()
	plyAttacker:Spectate( OBS_MODE_CHASE )
	if VictimType == 1 and plyVictim and plyVictim:IsValid() then
		plyVictim:StripWeapons()
		plyVictim:Spectate( OBS_MODE_CHASE )
		plyVictim.Raping = true
	end
	
	local basepos = plyAttacker:GetPos() + Vector(0,0,20)
	local traceda = {}
	traceda.start = basepos
	traceda.endpos = basepos - Vector(0,0,1000)
	traceda.filter = {plyVictim, plyAttacker}
	local trace = util.TraceLine(traceda)
	basepos = trace.HitPos or basepos

	local animNum = math.random(1, #angles)

	local ragVictim = NULL
	if VictimType == 3 then
		ragVictim = plyVictim
	else
		ragVictim = ents.Create("prop_ragdoll")
		ragVictim:SetModel( plyVictim:GetModel() )
		ragVictim:SetPos( plyVictimPos + (angles[animNum].range or Vector(0,0,0)) )
		ragVictim:Spawn()
		ragVictim:Activate()
		ragVictim:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	for i = 1, 14 do
		local phys = ragVictim:GetPhysicsObjectNum(i)
		if phys and phys:IsValid() then
			phys:EnableMotion( true )
			phys:EnableCollisions( false )
			phys:SetAngles( angles[animNum].victim[i] or Angle(0,0,0) )
			if i==2 or i==5 or i==7 or i==10 or i==13 or i==14 or i == 3 or i==4 or i==8 or i==6 then phys:EnableMotion(false) end
		end
	end
	
	local ragAttacker = ents.Create("prop_ragdoll")
	ragAttacker:SetModel( plyAttacker:GetModel() )
	ragAttacker:SetPos( plyVictimPos )
	ragAttacker:Spawn()
	ragAttacker:Activate()
		ragAttacker:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
	for i = 1, 14 do
		local phys = ragAttacker:GetPhysicsObjectNum(i)
		if phys and phys:IsValid() then
			--phys:SetPos( plyVictimPos )
			phys:SetAngles( angles[animNum].attacker[i] or Angle(0,0,0) )
			phys:EnableMotion( true )
			phys:EnableCollisions( false )
			if i==2 or i==5 or i==7 or i==10 or i==13 or i==14 or i == 3 or i==4 or i==8 or i==6 then phys:EnableMotion(false) end
		end
	end

	plyAttacker:SpectateEntity( ragAttacker )
	if VictimType == 1 then
		plyVictim:SpectateEntity( ragVictim )
	elseif VictimType == 2 then
		plyVictim:SetPos( plyVictimPos + Vector(5000,5000,0) )
	elseif VictimType == 3 then
		
	end
	
	local thrustTimerString = "RapeThrust"..math.random(1337)
	local phys = ragAttacker:GetPhysicsObjectNum( 11 )
	local phys2 = ragVictim:GetPhysicsObjectNum( 11 )
	if phys and phys:IsValid() and phys2 and phys2:IsValid() then
		phys:SetVelocity( Vector( 0, 0, 100000 ) )
		phys2:SetVelocity( Vector( 0, 0, 100000 ) )
		timer.Create( thrustTimerString, 0.3, 0, function()
			phys:SetVelocity( Vector( 0, 0, ThrustVel ) )
			phys2:SetVelocity( Vector( 0, 0, ThrustVel ) )
			if math.random( 5 ) == 3 then
				ragVictim:EmitSound( sounds3[math.random(#sounds3)] )
			end
		end )
	end
	
	
	local soundTimerString = "EmitRapeSounds"..math.random(1337)
	timer.Create( soundTimerString, SoundDelay, 0, function()
		ragVictim:EmitSound( sounds[math.random(#sounds)] )
	end )
	
	timer.Simple( RapeLength, function()
	
		if plyAttacker and plyAttacker:IsValid() then
			plyAttacker:UnSpectate()
			plyAttacker:Spawn()
			plyAttacker:SetPos( plyAttackerPos )
			plyAttacker.Raping = false
			timer.Simple( 0.1, function() plyAttacker:Give( "weapon_rape" ) end )
		end
		if plyVictim and plyVictim:IsValid() then
			if VictimType == 1 then
				plyVictim:UnSpectate()
				if args[1] then
					timer.Simple(0.5, function ()
						plyVictim:Kill()
					end)
				else
					plyVictim:Spawn()
					plyVictim:SetPos( plyVictimPos )
				end
				plyVictim.Raping = false
			elseif VictimType == 2 then
				plyVictim:SetPos( plyVictimPos )
			elseif VictimType == 3 then
				for i = 1, 14 do
					local phys = ragVictim:GetPhysicsObjectNum(i)
					if phys and phys:IsValid() then
						phys:EnableMotion( true )
					end
				end
			end
		end
		
		SafeRemoveEntity( ragAttacker )
		if VictimType != 3 then SafeRemoveEntity( ragVictim ) end
		
		timer.Destroy( soundTimerString )
		timer.Destroy( thrustTimerString )

		ply.rapeCooldown = CurTime() + 5
	
	end )

end)

hook.Add( "CanPlayerSuicide", "RAPESWEP.CanPlayerSuicide", function( ply )
	if ply.Raping then
		return false
	end
end )
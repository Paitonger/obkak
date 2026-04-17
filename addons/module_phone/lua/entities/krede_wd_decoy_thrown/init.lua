-- t.me/urbanichka
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()

	self.Owner = self.Entity.Owner
	
	self.Entity:SetModel("models/weapons/w_slam.mdl")
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	phys:SetMass(6.5)
	end
end

function ENT:Think()
	if !self.Usetime then return false end
	if self.Usetime <= CurTime() then
		self:Remove()
	end
end

function ENT:Attract()
	
	if self:GetNWBool("Useless") == false then
		for k,npc in pairs(ents.FindInSphere(self:GetPos(), 1800)) do
			if npc != NULL and IsValid(npc) and npc:GetClass() == "npc_combine_s" or npc:GetClass() == "npc_metropolice" then
				npc:SetLastPosition( self:GetPos() )
				npc:SetSchedule( SCHED_FORCED_GO_RUN )
			end
		end
		self:EmitSound("ambient/alarms/train_horn_distant1.wav")
	
		self.Usetime = CurTime() + 10
		self:SetNWBool("Useless", true)
	end
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end
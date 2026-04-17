-- 17.04
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

util.AddNetworkString( "derma" )



function ENT:Initialize( )
	self:SetModel( "models/Humans/Group01/male_02.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE, CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
end

function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput( Name, Activator, Caller )	

	if !Activator.cantUse and Activator:IsPlayer() then
		Activator.cantUse = true
		net.Start( "derma" )
			net.WriteEntity(self)
		net.Send( Activator )
		timer.Simple(1.5, function()
			Activator.cantUse = false
		end)
	end
end


concommand.Add("spawnnpcwayzer", function( pl, cmd ) 
		NPC = ents.Create("npc_way")
		NPC:SetPos(pl:GetPos())
		NPC:SetAngles(pl:GetAngles())
		NPC:Spawn()
end)
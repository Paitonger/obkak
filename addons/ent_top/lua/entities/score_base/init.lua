-- t.me/urbanichka
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName )
	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos + Vector( 0, 0, 150 ) )
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Initialize()
	self:SetModel("models/props/cs_assault/billboard.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:SetMaterial( "models/debug/debugwhite")
	self:SetColor( Color( 0, 0, 0 ) )
	
	local phys = self:GetPhysicsObject()
	phys:EnableMotion( false )
end

util.AddNetworkString( "stream_score" )

function ENT:setScoreData( tab )
	if ( type( tab ) != "table" ) then return end
	
	net.Start( "stream_score" )
		net.WriteEntity( self )
		net.WriteTable( tab )
	net.Broadcast()
	
	self.score_data = tab
end

function ENT:Think()
	self.Fetch(function(data)
        self:setScoreData( data )
    end)

    self:NextThink(CurTime() + 180)
    return true
end

util.AddNetworkString( "get_score_data" )

net.Receive( "get_score_data", function( length, ply ) 
	local ent = net.ReadEntity()
	
	if ( !ent.score_data ) then return end
	
	net.Start( "stream_score" )
		net.WriteEntity( ent )
		net.WriteTable( ent.score_data )
	net.Send( ply )
end )

hook.Add( "PlayerInitialSpawn", "addDRPName", function( ply )
    timer.Simple(60, function()
        if not IsValid(ply) then return end
        DarkRP.offlinePlayerData(ply:SteamID(), function(d)
            if d.rpname and d.rpname ~= '' and d.rpname ~= 'NULL' then return end
            DarkRP.storeRPName(ply, ply:getDarkRPVar("rpname"))
            ply:setDarkRPVar("rpname", ply:getDarkRPVar("rpname"))
        end)
    end)
end)
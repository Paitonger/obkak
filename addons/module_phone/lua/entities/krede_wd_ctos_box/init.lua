-- t.me/urbanichka
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel("models/props_lab/partsbin01.mdl")
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)     
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)   
	self.Entity:SetSolid(SOLID_VPHYSICS)       
	self.Entity:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if IsValid( phys ) then
	
		phys:EnableMotion(false)
	
	end
	
	self.Childs = {}
end

function ENT:Think()
	for i = 1, #self.Childs do
		local ent = self.Childs[i]
		if !IsValid(ent) or ent == NULL then table.remove(self.Childs, i) right = nil return false end
		for k,v in pairs(Krede_WD_HaxList) do
			if ent:GetClass() == k or string.find(k, "*") and string.find(ent:GetClass(), string.gsub(k,"*","")) then
				right = true
			end
		end
		if !right then
			table.remove(self.Childs, i)
			right = nil
			continue
		end
		right = nil
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
function ENT:Use( activator )
end

function ENT:Start( activator )
	if self:GetNWInt("Difficulty") == 0 then
		self:Hack( activator )
	else
		net.Start("ctOS-Box-Hack")
			net.WriteEntity(self)
		net.Send( activator )
	end
end

function ENT:Hack( activator )
	for i = 1, #self.Childs do
		local ent = self.Childs[i]
		for k,v in pairs(Krede_WD_HaxList) do
			if ent:GetClass() == k or string.find(k, "*") and string.find(ent:GetClass(), string.gsub(k,"*","")) then
				v.use(ent,activator, true)
			end
		end
	end
end

function ENT:AddChild(ent)
	if ent:GetClass() == self:GetClass() then return false end
	for k,v in pairs(Krede_WD_HaxList) do
		if ent:GetClass() == k or string.find(k, "*") and string.find(ent:GetClass(), string.gsub(k,"*","")) then
			table.insert(self.Childs, ent)
			return false
		end
	end
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
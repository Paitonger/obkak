-- t.me/urbanichka
ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.PrintName = "Скупщик мета"
ENT.Author = "Meth"
ENT.Contact = "Steam"
ENT.Category	= "Meth"

ENT.AutomaticFrameAdvance = true
   
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:PhysicsCollide( data, physobj )
end

function ENT:PhysicsUpdate( physobj )
end

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end 
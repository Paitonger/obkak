-- 17.04
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel('models/props_c17/BriefCase001a.mdl')
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    phys:Wake()
end

function ENT:Use(pl)
	if pl:IsValid() and pl:IsPlayer() then
		pl:giveRadio()
        self:Remove()
	end
end
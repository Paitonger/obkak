-- 17.04
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Бомба"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Other"
ENT.Author = "WayZer"
ENT.Contact = "wayzerroleplay@gmail.com"
ENT.Purpose = "Самое время чтобы что-нибудь жахнуть!"
ENT.Model = "models/weapons/w_c4_planted.mdl"

function ENT:SetupDataTables() 
	self:NetworkVar( "Bool", 0, "StartBomb");
end

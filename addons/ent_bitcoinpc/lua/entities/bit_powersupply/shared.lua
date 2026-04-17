-- 17.04
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Power Supply"
ENT.Author = "Mikael"
ENT.Category = "Запрещено"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Point" )
end
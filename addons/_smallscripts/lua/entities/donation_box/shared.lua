-- 17.04

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Author = "Matrix"

ENT.PrintName = "Hobo Donation Chest"
ENT.Category = "DarkRP Entities"
ENT.Spawnable = false

function ENT:SetupDataTables()
    -- The owner of the Entity
    self:NetworkVar("Entity", 0, "owning_ent")
    -- How much money the Entity is holding
    self:NetworkVar("Int", 1, "Money")
end
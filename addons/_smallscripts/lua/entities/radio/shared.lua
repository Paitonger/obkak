-- t.me/urbanichka
ENT.Type = 'anim'
ENT.Base = 'base_anim'
ENT.PrintName = 'Радио'
ENT.Author = 'doxzter'
ENT.Category = "Разрешено"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar('String', 1, 'URL')
    self:NetworkVar('Int', 1, 'StartTime')
    self:NetworkVar('Bool', 2, 'Loop')
end